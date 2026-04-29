# SMAT - Sistema de Monitoreo de Alerta Temprana 2026

## Información del Estudiante
* **Estudiante:** Jhonathan Gomez
* **Curso:** Desarrollo Basado en Plataformas
* **Facultad:** Facultad de Ingeniería de Sistemas e Informática (FISI)
* **E.P.:** Ciencias de la Computación

---

## Descripción del Proyecto
Este proyecto es el resultado del Laboratorio de **Ecosistema Móvil e Interoperabilidad**. La solución integra una aplicación móvil híbrida desarrollada en **Flutter** con un backend de alto rendimiento construido en **FastAPI**. El sistema permite el consumo de datos en tiempo real y la gestión eficiente de estaciones de monitoreo ambiental.

## Arquitectura del Sistema
El ecosistema se basa en una arquitectura desacoplada de dos componentes principales:

1.  **Backend (FastAPI + SQLAlchemy):**
    * Gestión de modelos de datos para `estaciones` y `lecturas`.
    * Persistencia de datos mediante SQLite.
    * API RESTful con documentación automática en Swagger UI.
2.  **Mobile (Flutter):**
    * Aplicación con arquitectura de capas (Modelos, Servicios e Interfaces).
    * Comunicación asíncrona mediante el paquete `http`.
    * Interfaz moderna optimizada con Material 3.

---

## Reto Superado: "Live Update"
Se implementó con éxito la funcionalidad de **Actualización Dinámica**, cumpliendo estrictamente con los requerimientos del laboratorio:

* **Lógica de Refresco:** Implementación de un método de actualización que utiliza `setState` para reiniciar el `FutureBuilder`, permitiendo obtener nuevos datos del servidor sin reiniciar la aplicación.
* **Interfaz de Usuario:** Inclusión de un `FloatingActionButton.extended` con el icono `Icons.refresh` para facilitar la interacción del usuario.
* **Validación de Interoperabilidad:** Sincronización exitosa verificada entre el ingreso de datos en Swagger y la actualización inmediata en el cliente móvil.

---

## Tecnologías Utilizadas
* **Lenguajes:** Dart (Flutter), Python (FastAPI).
* **Interoperabilidad:** Protocolo HTTP y formato de intercambio de datos JSON.
* **Herramientas de Desarrollo:** VS Code, Git y Flutter SDK.