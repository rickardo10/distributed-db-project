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

Además, la base de datos escala automáticamente de forma horizontal sin comprometer la funcionalidad. A lo anterior lo llaman ***sharding*** que es el proceso de almacenar documentos a travez de múltiples máquinas. Así, se agregan la cantidad de servidores que cubran la demanda de operaciones de lectura y escritura y automáticamente se balancean las cargas.


# Conocimientos previos

## Sharding

***Sharding*** es un método para el almacenamiento de datos en múltiples máquinas. Este método es utilizado por MongoDB para desplegar grandes bases de datos y grandes operaciones de salidar; este tipo de características pueden sobrepasar la capacidad de almacenamiento y procesamiento de una máquina. Además, trabajar con cantidades de datos que superan la RAM estrela la capacidad de I/O de los discos duros. Para atacar este poblema en MongoDB se utilizan dos aproximaciones: (1)
**vertical scaling** y (2) **sharding**. **Sharding** o escalamiento horizontal divide el conjunto de datos y lo distribuye a traves de los servidores o **shard**. Cada **shard** es una base de datos independiente y colectivamente los shards hacen una sola base de datos lógica. Por otro lado, el **vertical scaling** consta de agregar más CPUs y recursos de almacenamiento para incrementar la capacidad.

Las ventajas de **sharding** son:
* Reduce el númer ode operaciones que cada servidor maneja. Cada servidor maneja menos operaciones con forme se agregan nodos.
* Reduce la cantidad de datos en cada servidor.
* Aumenta la disponibilidad de los datos, ya que cada servidor puede ser replicado.

## Arquitectura de un cluster en MongoDB

En la siguiente imagen se muestra la configuración de un cluster de shards. Un cluster de shards está compuesto por los siguietnes componentes: *shards*, *query routers* y *config servers*.

![Arquitectura Cluster](/images/arquitectura.png)

La función de cada uno de los componentes es la siguiente:

* Los **Shards** almacenan los datos. En clusters de producción, cada shard es un **conjunto de réplica**. Así se provee alta disponibilidad y consistencia de datos. Un conjunto de réplica son servidores que contienen los mismos datos y se sincronizan.

* Los **Query Routers** también conocidos como **mongos instances**, son las interfaces que mantienen la comunicación con las aplicaciones del cliente y operaciones directas. El query router procesa y enfoca las operaciones a los shards y luego devuelve los resultados a los clientes. Para mantener disponibilidad un cluster de shards debe contener más de un query router.

* Los **Config servers** almacenan los metadatos del cluster. Estos datos mapean los datos a los shards. El query router utiliza estos metadatos para enfocar las operaciones al shard specífico. En clusters de producción se contienen 3 config servers.

## Particionamiento de datos

MongoDB distribuye los datos a un nivel de collección. Las particiones se llevan a cabo por medio de un **shard key**. Una shard key es un campo indexado. Todos los documentos que están en una colección distribuida deben tener una shard key. MongoDB divide los documentos en **chunks** y distribuye los chunks, aproximadamente del mismo tamaño, en todos servidores.

Una manera de distribuir los datos es llamado **hash based sharding**; consta de calcular un hash del valor de un campo y utiliza los hashes para crear los chunks. La ventaja de este tipo de partición es que se divide de manera aleatoria la información. En la siguiente figura se muestra el procedimiento.

![Sharding](/images/sharding.png)

## Balance de la distribución de los datos

Al insertar documentos, o eliminar documentos en una collección, se puede perder el balance en el cluster. Lo que significa, que un servidor puede llegar a tener más o menos chunks que otros. Además, es pósible que el tamaño de un chunk sea significativamente mayor que otros. Para prevenir este tipo de situaciones MongoDB corre dos procesos (1) **Splitting** y (2) **Balancing**. Splitting es un *background process* que evita que los chunks crezcan demasiado. Cuando un chunk
crece demasiado lo divide entre dos y modifica los metadatos en el config server. Por otro lado, en el fondo corre el proceso **balancer** el cual administra la migración de chunks. El balancer corre en todos los query routers en un cluster. Cuando la distribución en un cluster no está equilibrada, el proceso balancer migra chunks de un servidor a otro hasta que todos tienen aproximadamente la misma cantidad de datos. 

### Adición y eliminación de clusters

Cuando se **agrega** un cluster se crea una falta de balance ya que el nuevo servidor no tiene chunks, el balancer migra chunks de otros servidores al nuevo hasta que todos tienen aproximadamente la misma cantidad de chunks. Cuando se **elimina** un shard, el balancer migra todos los chunks del shard que se va a eliminar a los demás, al momento de migrar todos los datos y actualizar los metadatos, se quita seguramente los shards.

# Ejecución del código

Se requiere contar con Vagrant y VirtualBox previamente instalados para ejecutar el código del repositorio.

Para ejecutar el código primero se tiene que clonar este repositorio y acceder a la carpeta.

```bash
git clone https://github.com/rickardo10/distributed-db-project.git
cd distributed-db-project
```

Después, se crean todos los nodos y se configuran al correr.

```bash
vagrant up
```

Es necesesario que el usuario `vagrant` esté en sesión iniciada para se inicie el daemon de MongoDB y se puedan comunicar los servidores.

Para que los datos se repliquen, es necesario iniciar un conjunto de réplica en el nodo que se quiera como maestro y agregar al nodo en el que se quiere que se repliquen todos los datos.

```bash
mongo shard01:27040
rs.initiate()
rs.add("shard02:27040")
exit
```

Después, se inicia una un mongo shell de un query server para agregar los shards y los conjuntos de réplica al cluster.

```bash
mongo query01:27019
sh.addShard("shard03:27040")
sh.addShard("rep1/shard01:27040,shard02:27040")
exit
```

Para verificar que existe un balanceo de datos entre los shards se agregan datos con las siguientes operaciones.

```javascript
mongo shard01:27040
use test
var bulk = db.test_collection.initializeUnorderedBulkOp();
people = ["Marc", "Bill", "George", "Eliot", "Matt", "Trey", "Tracy", "Greg", "Steve", "Kristina", "Katie", "Jeff"];
for(var i=0; i<1000000; i++){
       user_id = i;
       name = people[Math.floor(Math.random()*people.length)];
       number = Math.floor(Math.random()*10001);
       bulk.insert( { "user_id":user_id, "name":name, "number":number });
}
bulk.execute();
exit
```

Antes de que comience el cluster a balancearse, se debe de permitir el **sharding** en la base de datos de la siguiente manera.

```javascript
mongo query01:27019/admin
sh.enableSharding("test")
```

Luego se crea un índice en la shard key.

```javascript
use test
db.test_collection.ensureIndex( {number:1} )
```

Y se agrega la collección al shard.

```javascript
use test
sh.shardCollection( "test.test_collection", {"number":1} )
```

Se verifica que se están balanceando los shards.

```javascript
use test
db.stats()
db.printShardingStatus()
```

# Conclusión

MongoDB es una buena alternativa en la elección de una base de datos distribuida ya que fragmenta de manera automática las bases de datos. Además, el balance de los datos en cada uno de los servidores se hace automáticamente. Por otro lado, los query servers en conjunto de los config servers permiten que las queries sean trasparentes al usuario, por lo que el usuario no se percata que la información está contenida en bases de datos diferentes. Finalmente, la replicación también se
lleva a cabo de forma automática, ya que MongoDB ve a un conjunto de shards como uno solo conjúnto de replicación y se encarga de sincronizar los datos.
