<template>
  <div class="p-4">
    <h1 class="text-xl font-bold mb-4">Autor</h1>
    <div v-if="autor">
      <p><strong>Nombre:</strong> {{ autor.author }}</p>
      <p><strong>Nacionalidad:</strong> {{ autor.nationality }}</p>
      <p><strong>Año de nacimiento:</strong> {{ autor.birth_year }}</p>
      <p><strong>Campos:</strong> {{ autor.fields }}</p>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'

const autor = ref(null)
const route = useRoute()

onMounted(async () => {
  const response = await axios.get(`/api/autores/${route.params.id}`)
  autor.value = response.data
})
</script>