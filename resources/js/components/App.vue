<template>
  <div>
    <nav>
      <router-link to="/">Libros</router-link> |
      <router-link to="/autores">Autores</router-link> |
      <router-link to="/editoriales">Editoriales</router-link>
    </nav>
    <router-view />
  </div>
</template>