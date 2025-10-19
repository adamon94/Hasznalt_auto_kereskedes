<script setup>
import { useController } from '../stores/UIcontrol';

const store = useController();
</script>


<template>
    <div>
        <h1>{{ store.id }}</h1>
        <p>{{ store.isLogged}}</p>
    </div>
</template>