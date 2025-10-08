<script setup>
import { useController } from '../stores/UIcontrol';

const store = useController()

const logIn = ()=>{
store.closeLog()

store.logIn()
}

</script>


<template>
<div v-if="store.logValue" class="backdrop"></div>

<dialog :open="store.logValue">

<form action="" method="dialog">
<h5 class="mb-5">Kérem adja meg az adatokat!</h5>
<div>
<label class="me-3" >Felhasáló név:</label>
<input type="text">
</div>

<div class="mt-3">
    <label class="me-3" for="">Adja meg a jelszót</label>
    <input type="text">
</div>

<button  class="mt-4" @click="logIn()">Bejelentkezés!</button>

</form>

</dialog>


</template>


<style scoped>

form{
   
    vertical-align: middle;
    background-color: #BCB4CC;
    text-align: center;
    border-radius: 1rem;
    z-index: 100;
    height: 100%;
    padding-top:100px ;
    
    
}

dialog {
  position: fixed;
  top: 15vh;
  left: 25%;
  width: 42%;
  height: 70%;
  z-index: 100;
  border-radius: 30px;
  border: none;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.26);
  padding: 0;
  margin: 0;
  
}
.backdrop{
    
  position: fixed;
  top: 0;
  left: 0;
  height: 100vh;
  width: 100%;
  background-color: rgba(0, 0, 0, 0.75);
  z-index: 10;
}

</style>