import { createRouter, createWebHistory } from 'vue-router'
import LibrosList from '../components/LibrosList.vue'
import AutoresList from '../components/AutoresList.vue'
import EditorialesList from '../components/EditorialesList.vue'
import AutorShow from '../components/AutorShow.vue'
import EditorialShow from '../components/EditorialShow.vue'
import LibroShow from '../components/LibroShow.vue'

const routes = [
  { path: '/', component: LibrosList },
  { path: '/autores', component: AutoresList },
  { path: '/editoriales', component: EditorialesList },
  { path: '/autores/:id', component: AutorShow },
  { path: '/editoriales/:id', component: EditorialShow },
  { path: '/libros/:id', component: LibroShow },
]

export default createRouter({
  history: createWebHistory(),
  routes,
})