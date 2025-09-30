<script setup>
import RegistrationModal from './registrationModal.vue';
import { useController } from '../stores/UIcontrol';
import { onMounted } from 'vue';
import { RouterLink } from 'vue-router';

const useStore = useController();


</script>


<template>


<nav class="navBar">

<ul class="menu">

<li>
    <div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle"
          type="button"
          data-bs-toggle="dropdown"
          aria-expanded="false"
  >
    Szolgáltatásaink
  </button>
  <ul class="dropdown-menu">
    <li><router-link class="dropdown-item" href="#">Teszt vezetések</router-link></li>
    <li><a class="dropdown-item" href="#">Beszámítás</a></li>
    <li><a class="dropdown-item" href="#">Kedvező finanszírozás</a></li>
  </ul>
</div>  
</li>

<li>
  <div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle"
          type="button"
          data-bs-toggle="dropdown"
          aria-expanded="false"
  >
    Fiok adatok
  </button>
  <ul class="dropdown-menu">
    <li><router-link class="dropdown-item" href="#">Kedvenceim</router-link></li>
    <li><a class="dropdown-item" href="#">Keresett autóim</a></li>
    <li><a class="dropdown-item" href="#">Teszt vezetéseim</a></li>
  </ul>
</div>  
</li>

<li>
<button class="navBtn">Kínálatunk</button>

</li>
<li><button @click="useStore.showModal" class="navBtn">Regisztráció</button></li>
<li ><button @click="useStore.showLog" class="navBtn">Bejelentkezés</button></li>



</ul>

</nav>

</template>

<style scoped>

.navBar{
position: relative;
margin:auto;
width: 100%;
padding: 10px;
left: 4%;

}

.menu{
    display: flex;
    list-style: none;
    justify-content: center ;
    align-items: center;
    margin-top: 20px;
    margin-left: 150px;
}
li{
    margin-right: 2rem;
    margin-top: 10px;
}
.navBtn{
    text-decoration: none;
    font-size: medium;
    font-weight:bold;
    color: #536066;
    background-color: #C8BCCF;
    border: none;
    border-radius: 10px;
    padding:8px 25px;
}

.userLink{
text-decoration: none;
color: black;
font-size: 20px;
font-weight:bolder;

}
</style>