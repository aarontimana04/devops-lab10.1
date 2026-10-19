# Evidencias y cumplimiento del PDF

| Entregable | Estado verificado | Evidencia |
|---|---|---|
| Repositorio GitHub solicitado | Publicado y verificado en main | [Repositorio](https://github.com/aarontimana04/devops-lab10.1) |
| URL de repositorio Bitbucket | Público y verificado vía API | [Bitbucket](https://bitbucket.org/aarontimana04-devops/bitbucket_terraform_demo/src/main/) |
| Acceso de lectura al docente | Lectura pública disponible por solicitud del alumno | Repositorio público; no se realizó invitación individual |
| Estructura del proyecto | Implementada | Archivos de la raíz y `app/handler.py` |
| Pipeline con validaciones, plan y apply-production ejecutado | Pendiente: Bitbucket exige verificación en dos pasos | No hay ejecución remota ni captura de éxito |
| Bucket S3 y objeto tf-lambda-demo/terraform.tfstate | Creado y objeto remoto verificado | [Metadatos S3](aws/s3-state-metadata.json) y [captura](02-s3-estado.png) |
| Lambda en AWS | Active; LastUpdateStatus Successful | [Estado real](aws/lambda-status.json); captura pendiente |
| API AWS funcionando | HTTP 200 y Hello, UTEC! | [Respuesta real](aws/api-response.json) y [captura](04-api.png) |
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

La sesión AWS predeterminada estaba vencida al comenzar. El perfil local alternativo `devops-lab` pudo autenticar, pero recibió `AccessDenied` en `lambda:ListFunctions` y en consultas de políticas IAM. Esos resultados no prueban todos los permisos de creación; tampoco permiten afirmar que el despliegue esté autorizado o ejecutado. Tras recuperar el acceso, la sesión predeterminada se renovó y el despliegue inicial se ejecutó desde CLI local: 8 recursos creados. El role de ejecución Lambda se creó mediante Terraform. No se modificaron los permisos del usuario `devops-lab`.

## Capturas por agregar tras la ejecución real

1. `01-bitbucket-pipeline.png`: pipeline completo exitoso, incluyendo apply-production aprobado.
2. `02-s3-estado.png`: bucket y objeto `tf-lambda-demo/terraform.tfstate`.
3. `03-lambda.png`: función Lambda y su integración API Gateway.
4. `04-api.png`: URL, estado HTTP 200 y JSON de la petición real.

Guardar los enlaces al pipeline y al repositorio Bitbucket, así como la fecha de las capturas. No publicar claves AWS, tokens, cookies ni contenido del estado/plan Terraform.

## Repositorio público verificado

Importado desde GitHub a `aarontimana04-devops/bitbucket_terraform_demo`, rama `main`, con `is_private=false` confirmado por la API pública de Bitbucket. Su workspace fue creado y confirmado por el alumno.

Bitbucket muestra: `Two-step verification is required to enable Deployments`. El usuario debe registrar su propio segundo factor antes de continuar.
