@extends('layouts.app')

@section('content')
<div class="container mx-auto px-4 py-6">
    <h1 class="text-2xl font-bold mb-4">Detalles del Autor</h1>

    <div class="bg-white shadow-md rounded p-4 mb-4">
        <p><strong>Nombre:</strong> {{ $autor->author }}</p>
        <p><strong>Nacionalidad:</strong> {{ $autor->nationality }}</p>
        <p><strong>Año de nacimiento:</strong> {{ $autor->birth_year }}</p>
        <p><strong>Campos:</strong> {{ $autor->fields }}</p>
    </div>

    <a href="{{ route('autors.index') }}" class="inline-block px-4 py-2 bg-blue-500 text-white rounded">Volver</a>
</div>
@endsection
