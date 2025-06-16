<template>
  <div class="p-4">
    <h1 class="text-xl font-bold mb-4">Editorial</h1>
    <div v-if="editorial">
      <p><strong>Nombre:</strong> {{ editorial.publisher }}</p>
      <p><strong>País:</strong> {{ editorial.country }}</p>
      <p><strong>Fundación:</strong> {{ editorial.founded }}</p>
      <p><strong>Género:</strong> {{ editorial.genere }}</p>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'

const editorial = ref(null)
const route = useRoute()

onMounted(async () => {
  const response = await axios.get(`/api/editoriales/${route.params.id}`)
  editorial.value = response.data
})
</script>