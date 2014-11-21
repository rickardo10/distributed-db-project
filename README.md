# Resumen

Este repositorio contiene el código necesario para crear un cluster de [MongoDB](http://www.mongodb.org/). Cada uno de los nodos del cluster se virtualizan con [Vagrant](https://www.vagrantup.com/). A lo largo de este documento se menciona paso por paso como se fue construyendo el cluster. Además, se muestra el comportamiento de MongoDB con respecto a la *fragmentación* de la base de datos y la *replicación* de los datos. Se muestra cómo MongoDB balancea la información en los servidores para que cada servidor tenga aproximadamente la misma cantidad de datos. Finalmente, se presenta cómo MongoDB permite hacer  *consultas*, *inserciones* y *actualizaciones* tranparentes para el usuario.

# Introducción

## Vagrant

**Vagrant** provee un ambiente portable de trabajo que es fácil de configurar y reproducir. Además, es construido encima de tecnología estandar y controlado por un consistente flujo de trabajo para maximizar la productividad y flexibilidad. De esta manera, se crean máquinas virtuales encima de VirtualBox, VMware, AWS, o cualquier otro provedor; depués, es posible utilizar herramientas para provicionar scripts de shell, Chef, o Puppet y así configurar cada una de las máquinas virtuales.

Se utiliza Vagrant, ya que aisla las dependencias y su configuración en un ambiente de desarrollo que puede ser desechable sin sacrificar ninguna de las herramientas con las que se está trabajando. Es tan simple como crear una [Vagrantfile](https://docs.vagrantup.com/v2/vagrantfile/) y correr el comando `vagrant up` y el ambiente se instalará automáticamente. Por otro lado, si al momento de trabajar se arruina la configuración y es más difícil buscar el error; sólo se tiene que
destruir el ambiente con `vagrant destroy` y volverlo a montar con `vagrant up`.

## MongoDB

**MongoDB** es una base de datos escrita en C++ que es NoSQL. En lugar de almacenar tablas, MongoDB almacena documentos con estilo JSON, lo que provee esquemas dinámicos, simplicidad y poder. A diferencia de otras bases de datos no relacionales, mongo soporta un índex completo en cada uno de los atributos.

Uno de los aspectos importantes en MongoDB son los **conjuntos de replicación**. Estos conjuntos son procesos que mantienen mantienen el mismo conjunto de datos almacenados en diferentes servidores. Los conjuntos de replicas proven redundancia y alta disponibilidad.  

Además, la base de datos escala automáticamente de forma horizontal sin comprometer la funcionalidad. A lo anterior lo llaman **sharding** que es el proceso de almacenar documentos a travez de múltiples máquinas. Así, se agregan la cantidad de servidores que cubran la demanda de operaciones de lectura y escritura y automáticamente se balancean las cargas.
