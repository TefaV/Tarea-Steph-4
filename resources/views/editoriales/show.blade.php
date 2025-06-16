@extends('layouts.app')

@section('content')
<div class="container mx-auto px-4 py-6">
    <h1 class="text-2xl font-bold mb-4">Detalles de la Editorial</h1>

    <div class="bg-white shadow-md rounded p-4 mb-4">
        <p><strong>Nombre:</strong> {{ $editorial->publisher }}</p>
        <p><strong>País:</strong> {{ $editorial->country }}</p>
        <p><strong>Fundada en:</strong> {{ $editorial->founded }}</p>
        <p><strong>Género:</strong> {{ $editorial->genere }}</p>
    </div>

    <a href="{{ route('editorials.index') }}" class="inline-block px-4 py-2 bg-blue-500 text-white rounded">Volver</a>
</div>
@endsection
