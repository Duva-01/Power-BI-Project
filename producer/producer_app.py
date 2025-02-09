from kafka import KafkaProducer
import json
import random
from datetime import datetime
import time

# Conexión a Kafka
try:
    producer = KafkaProducer(
        bootstrap_servers='localhost:9092',  # <--- "localhost:9092"
        value_serializer=lambda v: json.dumps(v).encode('utf-8')
    )
    print("✅ Conexión exitosa con Kafka (Productor).")
except Exception as e:
    print(f"❌ Error de conexión con Kafka (Productor): {e}")
    exit()

# Simulación de ventas
def generar_venta():
    venta = {
        "cliente_id": random.randint(1, 5),
        "producto_id": random.randint(1, 5),
        "empleado_id": random.randint(1, 5),
        "region_id": random.randint(1, 5),
        "cantidad": random.randint(1, 5),
        "total": random.randint(100, 5000),
        "fecha": datetime.now().isoformat()
    }
    return venta

if __name__ == "__main__":
    print("🚀 Iniciando Productor de Ventas...")
    while True:
        venta = generar_venta()
        try:
            future = producer.send('ventas_stream', venta)
            # Esperar confirmación de Kafka
            result = future.get(timeout=10)
            print(f"📤 Venta enviada con éxito: {venta}")
            print(f"📦 Info del mensaje => Topic: {result.topic}, Partition: {result.partition}, Offset: {result.offset}")
        except Exception as e:
            print(f"❌ Error al enviar la venta: {e}")
        time.sleep(5)
