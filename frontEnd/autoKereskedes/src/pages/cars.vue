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
 <section>

  <div class="section__container deals__container">
  <h2 class="section__header">Most popular car rental deals</h2>
        <p class="section__description">
          Explore our top car rental deals, handpicked to give you the best
          value and experience. Book now and drive your favorite ride at an
          incredible rate!
        </p>
        <div class="deals__tabs">
          <button class="btn" >Susuki</button>
          <button class="btn" >Citroen</button>
          <button class="btn" >BMW</button>
          <button class="btn" >Toyota</button>
          <button class="btn" >Opel</button>
          <button class="btn" >Golf</button>
        </div>
        <div class="tab__content">

             <div id="Tesla" class="tab__content active">

               <div class="deals__card">
            <img  alt="deals" />
            
            <h4>Tesla Model S</h4>
            <div class="deals__card__grid">
              <div>
                <span><i class="ri-group-line"></i></span> 4 People
              </div>
              <div>
                <span><i class="ri-steering-2-line"></i></span> Autopilot
              </div>
              <div>
                <span><i class="ri-speed-up-line"></i></span> 400km
              </div>
              <div>
                <span><i class="ri-car-line"></i></span> Electric
              </div>
            </div>
            <hr />
            <div class="deals__card__footer">
              <h3>$180<span>/Per Day</span></h3>
              <a href="#">
                Rent Now
                <span><i class="ri-arrow-right-line"></i></span>
              </a>
            </div>
          </div>



             </div>

          



        </div>


  </div>

 </section>
</template>

<style scoped>

.section__container {
  max-width: var(--max-width);
  margin: auto;
  padding: 5rem 1rem;
}

.section__header {
  margin-bottom: 1rem;
  font-size: 2.5rem;
  font-weight: 600;
  color: var(--text-dark);
  line-height: 3.25rem;
  text-align: center;
}

.section__description {
  color: var(--text-light);
  text-align: center;
  line-height: 1.5rem;
}

.btn {
  padding: 0.75rem 1.5rem;
  outline: none;
  border: none;
  font-size: 1rem;
  color: var(--white);
  background-color: var(--primary-color);
  border-radius: 0.5rem;
  transition: 0.3s;
  cursor: pointer;
}

.btn:hover {
  background-color: var(--primary-color-dark);
}

img {
  display: flex;
  width: 100%;
}

.about__container .section__description {
  max-width: 600px;
  margin-inline: auto;
  margin-bottom: 4rem;
}


.about__grid {
  display: grid;
  gap: 2rem 1rem;
}

.about__card {
  max-width: 300px;
  margin-inline: auto;
  text-align: center;
}

.about__card span {
  display: inline-block;
  margin-bottom: 2rem;
  font-size: 2.5rem;
  padding: 16px 20px;
  border-radius: 1.25rem;
  box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.05);
}

.about__card:nth-child(1) span {
  color: #8a79f0;
  background-color: #eeebfd;
}


.about__card h4 {
  margin-bottom: 10px;
  font-size: 1.2rem;
  font-weight: 600;
  color: var(--text-dark);
}

.about__card p {
  color: var(--text-light);
  line-height: 1.5rem;
}

.deals {
  background-color: var(--extra-light);
}

.deals__container .section__description {
  max-width: 600px;
  margin-inline: auto;
  margin-bottom: 4rem;
}

.deals__tabs {
  margin-bottom: 2rem;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.deals__tabs .btn {
  font-weight: 600;
  color: var(--primary-color-dark);
  background-color: var(--white);
}



/*.deals__container .tab__content {
  display: none;
  gap: 1rem;
  animation: fadeEffect 1s;
}*/

.deals__container .tab__content {
  display: grid;
}

@keyframes fadeEffect {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

.deals__card {
  padding: 1rem;
  background-color: var(--white);
  border-radius: 1rem;
  box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
}

.deals__card img {
  margin-bottom: 1rem;
}



.deals__card h4 {
  margin-bottom: 1rem;
  font-size: 1.2rem;
  font-weight: 600;
  color: var(--text-dark);
}

.deals__card__grid {
  margin-bottom: 2rem;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
}

.deals__card__grid div {
  display: flex;
  align-items: center;
  gap: 10px;
  color: var(--text-light);
}

.deals__card__grid div span {
  font-size: 1.2rem;
}

.deals__card__footer {
  margin-top: 1rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
}

.deals__card__footer h3 {
  font-size: 1.75rem;
  font-weight: 600;
  color: var(--text-dark);
}


.deals__card__footer a {
  font-weight: 600;
  color: var(--primary-color);
}





</style>