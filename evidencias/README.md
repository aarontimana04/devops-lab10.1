# Evidencias y cumplimiento del PDF

| Entregable | Estado verificado | Evidencia |
|---|---|---|
| Repositorio GitHub solicitado | Código preparado para publicación | [Repositorio](https://github.com/aarontimana04/devops-lab10.1) |
| URL de repositorio Bitbucket | Pendiente: iniciar sesión e identificar workspace | Sin URL confirmada |
| Acceso de lectura al docente | Pendiente: falta su usuario Bitbucket | Sin invitación realizada |
| Estructura del proyecto | Implementada | Archivos de la raíz y `app/handler.py` |
| Pipeline con validaciones, plan y apply-production ejecutado | Pendiente | No hay captura remota |
| Bucket S3 y objeto tf-lambda-demo/terraform.tfstate | Pendiente | No hay captura remota |
| Lambda en AWS | Pendiente | No hay captura remota |
| API AWS funcionando | Pendiente | No hay captura remota |
| Validaciones locales adicionales | Aprobadas | [Logs locales](local) |

## Resultados locales

- [Versión de Terraform](local/01-versiones.txt).
- [Invocación local del handler](local/02-handler.txt).
- [Formato Terraform](local/03-formato.txt).
- [Validación Terraform](local/04-terraform-validate.txt).
- [Lint Python](local/05-lint.txt).
- [Cuatro pruebas del contrato del handler](local/06-tests.txt).
- [Parseo y comprobaciones locales del YAML](local/07-yaml.txt).

Los logs tienen hora UTC y código de salida. No reemplazan las capturas exigidas por el PDF. No se reutilizan como propias las capturas de ejemplo de la guía o del PDF.

## Accesos comprobados

La sesión AWS predeterminada estaba vencida al comenzar. El perfil local alternativo `devops-lab` pudo autenticar, pero recibió `AccessDenied` en `lambda:ListFunctions` y en consultas de políticas IAM. Esos resultados no prueban todos los permisos de creación; tampoco permiten afirmar que el despliegue esté autorizado o ejecutado. No se modificaron permisos IAM.

## Capturas por agregar tras la ejecución real

1. `01-bitbucket-pipeline.png`: pipeline completo exitoso, incluyendo apply-production aprobado.
2. `02-s3-estado.png`: bucket y objeto `tf-lambda-demo/terraform.tfstate`.
3. `03-lambda.png`: función Lambda y su integración API Gateway.
4. `04-api.png`: URL, estado HTTP 200 y JSON de la petición real.

Guardar los enlaces al pipeline y al repositorio Bitbucket, así como la fecha de las capturas. No publicar claves AWS, tokens, cookies ni contenido del estado/plan Terraform.
