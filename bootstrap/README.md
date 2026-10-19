# Acceso AWS del pipeline mediante OIDC

Este bootstrap se ejecutó mediante AWS CLI fuera del estado Terraform del laboratorio. La infraestructura de aplicación conserva los ocho recursos de la guía.

- Emisor: `https://api.bitbucket.org/2.0/workspaces/aarontimana04-devops/pipelines-config/identity/oidc`.
- Audience: UUID del workspace, obtenido de la API pública.
- Trust del role: solo tokens cuyo `sub` comienza por el UUID de este repositorio. Otros repositorios no pueden asumirlo.
- Role: `bitbucket-lab10-terraform`.
- Permisos: bucket de estado y su prefijo, Lambda `tf-lambda-demo`, su role de ejecución y API HTTP `4ldgqb66wc` en us-east-1. La creación de API se permite en `/apis`; la administración posterior está limitada al ID existente. Recrear la API tras destroy exige actualizar ese ID en la política.
- `iam:PassRole` se limita al role de ejecución y al servicio Lambda. Solo puede adjuntarse AWSLambdaBasicExecutionRole a ese role.

El pipeline activa `oidc: true` en plan, apply y destroy, escribe el token del step en `/tmp/bitbucket-oidc-token` y establece `AWS_ROLE_ARN` y `AWS_WEB_IDENTITY_TOKEN_FILE`. El token no se publica como artifact ni se guarda en Git.

Es una adaptación de autenticación respecto a la guía, que usa Repository variables con claves AWS. No se copió la sesión root al pipeline ni se generaron claves permanentes. Se conserva validación paralela, plan, aprobación manual y deployment production.

[Documentación oficial Atlassian](https://support.atlassian.com/bitbucket-cloud/docs/deploy-on-aws-using-bitbucket-pipelines-openid-connect/).

La limpieza de la app con `terraform destroy` no elimina este proveedor OIDC ni su role, porque forman parte del bootstrap. Al terminar definitivamente el laboratorio, su política inline, role y proveedor se pueden retirar por separado después de comprobar que ningún otro uso depende de ellos.
