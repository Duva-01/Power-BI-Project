from kafka import KafkaConsumer
import psycopg2
import json

# Conexión a PostgreSQL
try:
    print("🔗 Conectando a la base de datos PostgreSQL...")
    conn = psycopg2.connect(
        dbname='postgres',
        user='postgres',
        password='postgres',
        host='localhost',  # PostgreSQL mapeado a localhost:5432
        port='5432'
    )
    cursor = conn.cursor()
    print("✅ Conexión a PostgreSQL establecida correctamente.")
except Exception as e:
    print(f"❌ Error al conectar a PostgreSQL: {e}")
    exit(1)

# Conexión a Kafka
try:
    print("🔗 Conectando al servidor de Kafka...")
    consumer = KafkaConsumer(
        'ventas_stream',
        bootstrap_servers='localhost:9092',  # <--- "localhost:9092"
        value_deserializer=lambda m: json.loads(m.decode('utf-8')),
        auto_offset_reset='earliest',
        enable_auto_commit=True
    )
    print("✅ Conexión a Kafka establecida correctamente.")
except Exception as e:
    print(f"❌ Error al conectar a Kafka: {e}")
    exit(1)

print("🟢 Consumidor de Ventas en ejecución...")

for message in consumer:
    data = message.value
    print(f"📥 Venta recibida de Kafka: {data}")

    try:
        cursor.execute("""
            INSERT INTO ventas (cliente_id, producto_id, empleado_id, region_id, cantidad, total, fecha)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (
            data['cliente_id'],
            data['producto_id'],
            data['empleado_id'],
            data['region_id'],
            data['cantidad'],
            data['total'],
            data['fecha']
        ))

        conn.commit()
        print(f"✅ Venta insertada en PostgreSQL correctamente: {data}")

    except Exception as e:
        print(f"❌ Error al insertar en PostgreSQL: {e}")
        conn.rollback()
