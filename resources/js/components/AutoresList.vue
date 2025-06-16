<template>
    <div class="p-4">
        <h1 class="text-xl font-bold mb-4">Lista de Autores</h1>
        <ul>
            <li v-for="autor in autores" :key="autor.id" class="mb-2">
                <strong>Nombre:</strong> {{ autor.author }}<br />
                <strong>Nacionalidad:</strong> {{ autor.nationality }}<br />
                <strong>Año de nacimiento:</strong> {{ autor.birth_year }}<br />
                <strong>Campos:</strong> {{ autor.fields }}
            </li>
        </ul>
    </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";

const autores = ref([]);

onMounted(async () => {
    try {
        const response = await axios.get("/api/autores");
        autores.value = response.data;
    } catch (error) {
        console.error("Error cargando autores:", error);
    }
});
</script>
