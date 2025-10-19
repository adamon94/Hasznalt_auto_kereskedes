<script setup>
import { useController } from '../stores/UIcontrol';
import { onMounted, ref } from 'vue';
import { RouterLink } from 'vue-router';
import { useRouter } from 'vue-router';

const router = useRouter()
const useStore = useController();



const logOut = ()=>{
  useStore.logOut()
  //router.push('/')
  location.reload();
}


</script>


<template>


<nav class="navBar">

<ul class="menu" :class="!useStore.isLogged ? 'menuGap ' : ''">

<li>
    <div class="dropdown">
  <button :class="{'menuBtnOut': !useStore.isLogged}" class="btn btn-secondary dropdown-toggle"
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

<li v-if="useStore.isLogged">
  <div  class="dropdown">
  <button class="btn btn-secondary dropdown-toggle"
          type="button"
          data-bs-toggle="dropdown"
          aria-expanded="false"
  >
    Fiok adatok
  </button>
  <ul class="dropdown-menu">
    <li><router-link to="/kedvencek" class="dropdown-item">Kedvenceim</router-link></li>
    <li><button class="dropdown-item" href="#">Keresett autóim</button></li>
    <li><a class="dropdown-item" href="#">Teszt vezetéseim</a></li>
  </ul>
</div>  
</li>

<li v-else >
  <div class="dropdown">
  <button :class="{'menuBtnOut': !useStore.isLogged}" class="btn btn-secondary dropdown-toggle"
          type="button"
          data-bs-toggle="dropdown"
          aria-expanded="false"
  >
    Fiok
  </button>
  <ul class="dropdown-menu">
    <li><button class="dropdown-item" @click="useStore.showLog">Bejelentkezés</button></li>
    <li><router-link class="dropdown-item" to="/registration">Regisztráció</router-link></li>
  </ul>
</div>  
</li>

<li>
<button @click="router.push('/about')" :class="{'menuBtnOut': !useStore.isLogged}" class="navBtn">Rólunk</button>
</li>

<li>
<button @click="router.push('/contact')" :class="{'menuBtnOut': !useStore.isLogged}" class="navBtn">Kapcsolat</button>
</li>

<li>
<button @click="router.push('/cars')" :class="{'menuBtnOut': !useStore.isLogged}" class="navBtn">Kínálatunk</button>
</li>
<li v-if="useStore.isLogged"><button @click="logOut" class="navBtn">Kijelentkezés</button></li>

</ul>

</nav>

</template>

<style scoped>

.navBar{
position: relative;
margin:auto;
width: 80%;
padding: 10px;
left: 5%;

}

.menu{
    display: flex;
    list-style: none;
    justify-content: center ;
    align-items: center;
    margin-top: 20px;
    margin-left: 150px;
    
}
.menuGap{
   gap: 0.5rem;
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
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    position: relative;
    overflow: hidden;
}

.menuBtnOut{
   padding:8px 40px;
}
.navBtn:hover {
    background-color: #A3C9C4;
    color: #fff;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(163, 201, 196, 0.4);
}

.navBtn:active {
    transform: translateY(0);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

.userLink{
text-decoration: none;
color: black;
font-size: 20px;
font-weight:bolder;

}
</style>