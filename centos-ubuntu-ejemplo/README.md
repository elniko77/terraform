# centos-ubuntu-ejemplo
Ejemplo para crear dos vms, una con ubuntu 20.04 y una con centos8, usando el plugin para kvm.


Las vms son creadas con las siguientes ip:

Ubuntu -> 192.168.122.11
Centos -> 192.168.122.22



Se crea a través del template templates/user_data.tpl un usuario llamado vmadmin que puede ejecutar sudo sin password. Estos ejemplos son para uso en un lab de pruebas.

En main.tf hay que cambiar el path donde se encuentran las cloudimages:

    source = "/home/nss/terraform/sources/${var.distros[count.index]}.qcow2"

Deberían estar descargadas y renombradas a centos.qcow2 y ubuntu.qcow2.

Source:
   https://cloud.centos.org/centos/8/x86_64/images/
   
   
   https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"

   



