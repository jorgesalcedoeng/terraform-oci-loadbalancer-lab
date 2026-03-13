# 🚀 OCI Load Balancer Lab with Terraform

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform)
![OCI](https://img.shields.io/badge/Oracle%20Cloud-OCI-red?logo=oracle)
![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/lab-learning-blue)

Laboratorio práctico para desplegar una **arquitectura con Load Balancer
en Oracle Cloud Infrastructure (OCI)** utilizando **Terraform y una
estructura modular**.

El proyecto demuestra cómo implementar **Infraestructura como Código
(IaC)** para crear un **Load Balancer público que distribuye tráfico
HTTP entre múltiples instancias compute** desplegadas en una subred
privada.

Este laboratorio está pensado para **aprendizaje, demostraciones
técnicas y compartir conocimiento sobre OCI + Terraform**.

------------------------------------------------------------------------

# 📐 Arquitectura

El laboratorio implementa una arquitectura simple donde un **OCI Load
Balancer público** distribuye tráfico entre **dos servidores Nginx**.

                             Internet
                                 │
                                 ▼
                       OCI Public Load Balancer
                           (HTTP Listener)
                                 │
                      ┌──────────┴──────────┐
                      ▼                     ▼
               Compute Instance 1     Compute Instance 2
                     (Nginx)                (Nginx)
                      │                     │
                      └────── Private Subnet ──────┘
                                │
                               VCN

------------------------------------------------------------------------

# 🧱 Recursos desplegados

## Networking

-   Virtual Cloud Network (**VCN**)
-   Public Subnet
-   Private Subnet
-   Internet Gateway
-   Route Tables
-   Network Security Groups

## Compute

-   2 instancias **OCI Compute**
-   Instalación automática de **Nginx** mediante `cloud-init`
-   Página web generada automáticamente para identificar el backend

## Load Balancing

-   **OCI Public Load Balancer**
-   Backend Set
-   Listener HTTP (puerto 80)
-   Health Checks HTTP
-   Política de balanceo **Round Robin**

------------------------------------------------------------------------

# 📂 Estructura del Proyecto

    oci-3tier/
    │
    ├── main.tf
    ├── outputs.tf
    │
    ├── modules
    │   │
    │   ├── network
    │   │   ├── vcn.tf
    │   │   ├── subnets.tf
    │   │   ├── gateways.tf
    │   │   ├── routes.tf
    │   │   └── outputs.tf
    │   │
    │   └── compute
    │       ├── loadbalancer.tf
    │       ├── data.tf
    │       ├── variables.tf
    │       ├── outputs.tf
    │       └── user_data.yaml

Esta estructura modular permite **reutilizar componentes y mantener el
código organizado**.

------------------------------------------------------------------------

# ⚙️ Variables principales

  Variable              Descripción
  --------------------- ------------------------------
  compartment_ocid      OCID del compartment
  vcn_cidr              CIDR de la VCN
  public_subnet_cidr    CIDR de la subred pública
  private_subnet_cidr   CIDR de la subred privada
  instance_shape        Shape de las instancias
  instance_image        Imagen del sistema operativo

------------------------------------------------------------------------

# ⚖️ Load Balancer

Configuración principal del balanceador:

  Configuración   Valor
  --------------- ----------------------
  Tipo            Public Load Balancer
  Shape           Flexible
  Listener        HTTP
  Puerto          80
  Política        Round Robin

### Health Check

    Protocol: HTTP
    Port: 80
    Path: /

------------------------------------------------------------------------

# 🔁 Flujo de tráfico

1.  El usuario accede a la **IP pública del Load Balancer**
2.  El **listener HTTP** recibe la conexión
3.  El **backend set** aplica la política **Round Robin**
4.  El tráfico se distribuye entre las dos VMs

Al refrescar la página se observará que **el backend cambia**, lo que
confirma que el balanceo funciona correctamente.

------------------------------------------------------------------------

# ▶️ Despliegue

### 1 Inicializar Terraform

``` bash
terraform init
```

### 2 Validar configuración

``` bash
terraform validate
```

### 3 Plan de ejecución

``` bash
terraform plan
```

### 4 Crear infraestructura

``` bash
terraform apply
```

------------------------------------------------------------------------

# 🧪 Prueba del laboratorio

1.  Obtener la **IP pública del Load Balancer**
2.  Abrir el navegador

```{=html}
<!-- -->
```
    http://LOAD_BALANCER_IP

3.  Refrescar varias veces

El **hostname del servidor cambiará**, demostrando que el balanceador
distribuye tráfico.

------------------------------------------------------------------------

# ⚠️ Troubleshooting

## Health Check "Inaccessible"

En algunos casos el **Health Check del Load Balancer puede aparecer como
`Inaccessible` o `Unhealthy`** después del despliegue.

Esto puede ocurrir porque:

-   `cloud-init` aún está ejecutándose
-   Nginx no terminó de instalarse
-   El servicio web aún no está activo

### Recomendación

Reiniciar las instancias compute.

Desde la consola OCI o CLI:

    Reboot VM1
    Reboot VM2

Después de reiniciar:

1.  Esperar algunos minutos
2.  Verificar nuevamente el estado del health check

Normalmente cambiará a **Healthy** cuando **Nginx responda en el puerto
80**.

------------------------------------------------------------------------

# 🎯 Objetivos del laboratorio

Este laboratorio permite aprender:

-   Infraestructura como código con **Terraform**
-   Arquitecturas modulares en Terraform
-   Configuración de **OCI Load Balancer**
-   Backend Sets y Health Checks
-   Automatización de servidores con **cloud-init**

------------------------------------------------------------------------

# 🧑‍💻 Tecnologías

-   Terraform
-   Oracle Cloud Infrastructure (OCI)
-   OCI Load Balancer
-   Nginx
-   Cloud-init

------------------------------------------------------------------------

# 📚 Posibles mejoras

Algunas extensiones posibles del laboratorio:

-   Implementar **HTTPS**
-   Agregar **OCI WAF**
-   Implementar **Auto Scaling**
-   Crear un **Bastion Host**
-   Integrar **Monitoring / Logging**
-   Implementar **Private Load Balancer**

------------------------------------------------------------------------

# 📖 Propósito

Este laboratorio fue creado con fines **educativos y de demostración
técnica**, para mostrar cómo desplegar una arquitectura simple de
**balanceo de carga en OCI usando Terraform** siguiendo buenas prácticas
de infraestructura como código.
