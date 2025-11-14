<script setup>
import NavBar from './navBar.vue';


</script>
<template>

<header class="head">

<div class="mould"></div>

<NavBar></NavBar>


</header>

</template>



<style scoped>

.head{
    width: 100%;
    position: relative;
    height: 130px;
    /*background-color:D0D8D9 ;*/
    background-color: #D0D8D9;
}

.mould{
    background-color: #A3C9C4;
    padding:50px;
    position: absolute;
    top: 15px;
    left:-40px;
    width: 25%;
    border-radius: 1.5rem;
    transform: skewX(40deg);
    
    
}

</style>