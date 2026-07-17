# Terraform Pipeline

Pipeline de GitHub Actions que reemplaza el uso de `terraform apply` local. Nadie aplica cambios de infra desde su máquina — todo pasa por este workflow.

## Cuándo se ejecuta

| Evento | Qué hace |
|--------|----------|
| Abrir o actualizar un PR hacia `main` | Valida y planifica, comenta el resultado en el PR |
| Merge a `main` | Valida, planifica y aplica los cambios en AWS |

---

## Secrets requeridos

Configurar en **GitHub → Settings → Secrets and variables → Actions**:

| Secret | Descripción |
|--------|-------------|
| `AWS_ACCESS_KEY_ID` | Access key del usuario IAM con permisos sobre la infra |
| `AWS_SECRET_ACCESS_KEY` | Secret key del mismo usuario |

---

## Pasos del pipeline

### 1. Checkout
Descarga el código del repo en el runner de GitHub.

### 2. Configure AWS Credentials
Inyecta las credenciales de AWS usando los secrets del repo. A partir de este paso todos los comandos de Terraform tienen acceso a la cuenta.

### 3. Setup Terraform
Instala la CLI de Terraform en el runner.

### 4. Terraform Init
```bash
terraform init
```
Inicializa el backend remoto (S3 + DynamoDB para state locking) y descarga los providers y módulos necesarios.

### 5. Terraform Format Check
```bash
terraform fmt -check
```
Verifica que todos los archivos `.tf` estén correctamente formateados. Si no lo están, el pipeline falla. Corregir con `terraform fmt` en local antes de pushear.

### 6. Terraform Validate
```bash
terraform validate
```
Valida que la sintaxis y la lógica de los archivos `.tf` sea correcta sin conectarse a AWS.

### 7. Terraform Plan
```bash
terraform plan -no-color -out=tfplan
```
Se conecta a AWS y calcula qué recursos se van a crear, modificar o destruir. Guarda el plan en el archivo `tfplan` para que el Apply ejecute exactamente lo que se mostró.

`continue-on-error: true` permite que el siguiente paso comente el error en el PR en lugar de cortar el pipeline silenciosamente.

### 8. Comment Plan on PR _(solo en PRs)_
Postea el output del Plan como comentario en el PR para que el equipo pueda revisarlo antes de aprobar el merge.

### 9. Terraform Plan Failed
Si el Plan falló, este paso fuerza la falla del pipeline para bloquear el merge.

### 10. Terraform Apply _(solo en merge a main)_
```bash
terraform apply -auto-approve tfplan
```
Aplica el plan guardado en el paso 7 contra AWS. Solo corre cuando hay un push directo a `main` (es decir, después de un merge).

---

## Flujo completo

```
Developer abre PR
       │
       ▼
  fmt check ──── falla ──→ pipeline rojo, corregir formato
       │
       ▼
   validate ──── falla ──→ pipeline rojo, corregir sintaxis
       │
       ▼
     plan ──────────────→ resultado comentado en el PR
       │
       ▼
  Code review + aprobación
       │
       ▼
   Merge a main
       │
       ▼
     apply ─────────────→ infra actualizada en AWS
```

---

## Working directory

El pipeline trabaja sobre `environments/staging/`. Si se agregan más entornos (ej: `environments/prod/`) se deberá crear un workflow separado o parametrizar este con una matrix.
