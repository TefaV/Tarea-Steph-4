<template>
  <div class="p-4">
    <h1 class="text-xl font-bold mb-4">Libro</h1>
    <div v-if="libro">
      <p><strong>Título:</strong> {{ libro.title }}</p>
      <p><strong>Edición:</strong> {{ libro.edition }}</p>
      <p><strong>Copyright:</strong> {{ libro.copyright }}</p>
      <p><strong>Idioma:</strong> {{ libro.language }}</p>
      <p><strong>Páginas:</strong> {{ libro.pages }}</p>
      <p><strong>Autor:</strong> {{ libro.autor?.author }}</p>
      <p><strong>Editorial:</strong> {{ libro.editorial?.publisher }}</p>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'

const libro = ref(null)
const route = useRoute()

onMounted(async () => {
  const response = await axios.get(`/api/libros/${route.params.id}`)
  libro.value = response.data
})
</script>