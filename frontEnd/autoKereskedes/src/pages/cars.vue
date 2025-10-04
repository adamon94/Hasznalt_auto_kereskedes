<script setup>
import { onMounted, ref } from 'vue';

const cars = ref([])
const carImages = ref()

onMounted(()=>{
    fetch("http://localhost:3300/cars/getCars").then(async (res) => {
    const data = await res.json();
    cars.value = data;
    
  });
})

 fetch("http://localhost:3300/cars/getCar/"+ 2).then(async (res) => {
    const data = await res.json();
    carImages.value = data.Images;
    console.log(carImages.value)
  });


</script>


<template>
 <!--
<div v-for="ar in cars" :key="ar.id">
    {{ ar.model }}
    {{ ar.ar }}
  <img :src="'http://localhost:3300/images/' + ar.Images[0]?.path" alt="">
</div>
<ul><li v-for="i in carImages" :key="i.image_id"><img :src="'http://localhost:3300/images/' + i.path" alt=""></li></ul>
 !-->
 <div>



  
 </div>
</template>

<style scoped>
img{
  height: 300px;
  width: 300x;
}
</style>