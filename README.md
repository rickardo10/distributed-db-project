# Resumen

Este repositorio contiene el código necesario para crear un cluster de [MongoDB](http://www.mongodb.org/). Cada uno de los nodos del cluster se virtualizan con [Vagrant](https://www.vagrantup.com/). A lo largo de este documento se menciona paso por paso como se fue construyendo el cluster. Además, se muestra el comportamiento de MongoDB con respecto a la *fragmentación* de la base de datos y la *replicación* de los datos. Se muestra cómo MongoDB balancea la información en los servidores para que cada servidor tenga aproximadamente la misma cantidad de datos. Finalmente, se presenta cómo MongoDB permite hacer  *consultas*, *inserciones* y *actualizaciones* tranparentes para el usuario.

# Introducción

**Vagrant** provee un ambiente portable de trabajo que es fácil de configurar y reproducir que es construido encima de tecnología estandar y controlado por un simple y consistente flujo de trabajo para maximizar la productividad y flexibilidad de un equipo de trabajo. De esta manera, se crean máquinas virtuales encima de VirtualBox, VMware, AWS, o cualquier otro provedor. Depués, es posible utilizar herramientas para provicionar scripts de shell, Chef, o Puppet para configurar cada
una de las máquinas virtuales.

Se utiliza Vagrant, ya que aisla las dependencias y su configuración en un ambiente de desarrollo que puede ser desechable sin sacrificar ninguna de las herramientas con las que se está trabajando. Es tan simple como crear una [Vagrantfile](https://docs.vagrantup.com/v2/vagrantfile/) y correr el comando `vagrant up` y el ambiente se instalará automáticamente. Por otro lado, si al momento de trabajar se arruina la configuración y es más difícil buscar el error; sólo se tiene que
destruir el ambiente con `vagrant destroy` y volverlo a montar con `vagrant up`.
