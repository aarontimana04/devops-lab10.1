# Evidencias y cumplimiento del PDF

| Entregable | Estado verificado | Evidencia |
|---|---|---|
| Repositorio GitHub solicitado | Publicado y verificado en main | [Repositorio](https://github.com/aarontimana04/devops-lab10.1) |
| URL de repositorio Bitbucket | Público y verificado vía API | [Bitbucket](https://bitbucket.org/aarontimana04-devops/bitbucket_terraform_demo/src/main/) |
| Acceso de lectura al docente | Lectura pública disponible por solicitud del alumno | Repositorio público; no se realizó invitación individual |
| Estructura del proyecto | Implementada | Archivos de la raíz y `app/handler.py` |
| Pipeline con validaciones, plan y apply-production ejecutado | SUCCESSFUL; validaciones, plan y apply manual aprobados | [Captura](https://github.com/aarontimana04/devops-lab10.1/blob/main/evidencias/01-bitbucket-pipeline.png), [logs remotos](ci) y [pipeline #1](https://bitbucket.org/aarontimana04-devops/bitbucket_terraform_demo/pipelines/results/1) |
| Bucket S3 y objeto tf-lambda-demo/terraform.tfstate | Creado y objeto remoto verificado | [Metadatos S3](aws/s3-state-metadata.json) y [captura](https://github.com/aarontimana04/devops-lab10.1/blob/main/evidencias/02-s3-estado.png) |
| Lambda en AWS | Active; LastUpdateStatus Successful | [Estado real](aws/lambda-status.json) y [captura](https://github.com/aarontimana04/devops-lab10.1/blob/main/evidencias/03-lambda.png) |
| API AWS funcionando | HTTP 200 y Hello, UTEC! | [Respuesta real](aws/api-response.json) y [captura](https://github.com/aarontimana04/devops-lab10.1/blob/main/evidencias/04-api.png) |
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

## Capturas publicadas

1. `01-bitbucket-pipeline.png`: pipeline completo exitoso, incluyendo apply-production aprobado.
2. `02-s3-estado.png`: bucket y objeto `tf-lambda-demo/terraform.tfstate`.
3. `03-lambda.png`: función Lambda y su integración API Gateway.
4. `04-api.png`: URL, estado HTTP 200 y JSON de la petición real.

Las cuatro capturas corresponden al 18 de octubre de 2026 (America/Lima). La captura del pipeline fue proporcionada por el alumno y se conserva sin editar. No se publica el estado ni el plan binario Terraform; los logs contienen nombres de variables, sin valores de credenciales.

## Repositorio público verificado

Importado desde GitHub a `aarontimana04-devops/bitbucket_terraform_demo`, rama `main`, con `is_private=false` confirmado por la API pública de Bitbucket. Su workspace fue creado y confirmado por el alumno.

El usuario activó la verificación en dos pasos y confirmó el correo. El YAML OIDC y la documentación se sincronizaron en Bitbucket mediante la integración Atlassian, commit `e2dd8f8a4dd37d43e061365a798c1b0be327abc5`. Pipelines quedó habilitado. El pipeline #1, UUID `{35f2ec66-753c-4236-913e-de7925feca6d}`, ejecutó las tres validaciones paralelas y el plan con éxito el 19 de octubre de 2026 (UTC). El plan propone 0 altas, 1 actualización del paquete Lambda y 0 eliminaciones. El alumno aprobó manualmente apply-production. El apply terminó con 0 altas, 1 cambio y 0 eliminaciones; el smoke test devolvió Hello, UTEC! y la consulta posterior confirmó HTTP 200. El pipeline finalizó SUCCESSFUL el 18 de octubre de 2026 a las 21:42:30 (America/Lima; 19 de octubre 02:42:30 UTC). Los logs originales y los estados de las cinco etapas están en `ci/`. Las imágenes se enlazan a GitHub, donde sí están publicadas.
