#servir pagina web alojada en S3 + CloudFront 

1. registrar dominio en internert(por ejemplo, godaddy)
    no lo vamos hacer de momento

2. crear bucket, sin el check de Block all public access
    1.upload contenido, ejemplo todo lo que hay dentro de directorio klassy_cafe_app
    1.habilitar, properties->Static website hosting

        me crea un endpoint para navegar al sito web
    3.permisos -> edit bucket policy
        {
            "Id": "Policy1697517511061",
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Sid": "Stmt1697517508860",
                    "Action": [
                        "s3:GetObject"
                    ],
                    "Effect": "Allow",
                    "Resource": "arn:aws:s3:::test.jgl/*",
                    "Principal": "*"
                }
            ]         
        }
3. route53(para enrutar dominio a los servidores DNS Amazon)    No lo hice   
    -Create hosted zone
    -hosteo(por ejemplo, en godaddy) los servidores DNS que me proporcionan en la pestaña 'Value/Route traffic to'(son 4)

4. ACM - certificado seguridad(para que no salga 'pagina web no segura')  No lo hice 
    crear certificado con el mismo dominio 
        una vez creado, seleccion create records en route53

5. CloudFront
    origin domain -> bucket s3
    añadir certificado si lo tenemos
    WAF disable-nose muy bien para que vale

    --una vez este enabled:
        setting:
            -alternative domanin name(CNAME): le pongo el dominio
            -default root object: pagina principal, index.html

6. Route53
    create record -> dominio y apunto a la distribucion de cloudFront