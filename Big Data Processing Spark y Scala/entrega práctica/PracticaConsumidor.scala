//importamos los paquetes necesarios para la ejecución del código
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.types.{IntegerType, StringType, StructType}
import org.apache.spark.sql.functions.{col, from_json}

//nuestro objeto Consumidor para la práctica
object PracticaConsumidor {
  def main(args:Array[String]): Unit ={

    //creamos la sparkSession
    val spark = SparkSession.builder().appName("kafkajson").master("local[2]").getOrCreate()

    //leemos un formato kafka, definimos la conexión al clúster, nos subscribimos al tema del que quermos leer
    //y empezamos a leer desde el principio
    val df = spark.readStream
      .format("kafka")
      .option("kafka.bootstrap.servers","localhost:9092")
      .option("subscribe","PracticaKafka")
      .option("startingOffsets","earliest")
      .load()

    //casteamos todos los datos leídos en formato kafka para convertirlos en strings
    val res = df.selectExpr("CAST(value AS STRING)")

    //creamos el schema según el formato de nuestro fichero
    val schemaPersonal = new StructType().add("id", IntegerType, true)
      .add("first_name", StringType, true)
      .add("last_name", StringType, true)
      .add("email", StringType, true)
      .add("gender", StringType, true)
      .add("ip_address", StringType, true)

    //relacionamos los datos leídos del tema de Kafka con el schema
    // y eliminamos las dos palabras elegidas
    val persona = res.select(from_json(col("value"), schemaPersonal).as ("data"))
      .select("data.*")
      .filter("data.first_name != 'Giavani'")
      .filter("data.last_name != 'Bea'")


    //mostramos por consola añadiendo los datos según vayan llegando
    print("mostrar los datos por consola")

    //escribimos por consola añadiendo la información según la vamos recibiendo
    // y dejamos el consumidor a la espera de que siga llegando información al tema suscrito
    persona.writeStream
      .format("console")
      .outputMode("append")
      .start()
      .awaitTermination()
  }
}
