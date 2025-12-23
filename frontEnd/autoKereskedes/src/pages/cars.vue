<script setup>
import { onMounted, ref } from 'vue';


const cars = ref([])

const formatNumber = (number) => {
  return new Intl.NumberFormat('hu-HU', { style: "currency", currency: "HUF" }).format(number);
}

onMounted(()=>{
    fetch("http://localhost:3300/cars/getCars").then(async (res) => {
    const data = await res.json();
    cars.value = data;
    console.log(cars.value)
  });
})

</script>


<template>
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
          <div v-for="car in cars" :key="car.id" class="deals__card mb-4">
            <img  :src="'http://localhost:3300/images/' + car.Images[0]?.path" alt="Deals" />
            <h4>{{ car.model }}</h4>
            <div class="deals__card__grid">
              <div>
                <span><i class="ri-group-line"></i></span> Férőhley: {{ car.ferohely }}
              </div>
              <div>
                <span><i class="ri-steering-2-line"></i></span> Váltó rendszer: {{ car.sebessegValtoRendszer }}
              </div>
              <div>
                <span><i class="ri-speed-up-line"></i></span> henger űrtartalom: {{ car.hengerUrTartalom}} cm³
              </div>
              <div>
                <span><i class="ri-car-line"></i></span> Üzemanyag: {{car.uzemAnyagTipus}}
              </div>
            </div>
            <hr />
            <div class="deals__card__footer">
              <h3>{{ car.ar }} HUF</h3>
              <router-link :to="'/cars/' + car.id">
                Tovább az adatlapra
                <span><i class="ri-arrow-right-line"></i></span>
              </router-link>
            </div>
          </div>
      </div>
    </div>
 </section>
</template>

<style scoped>


section{
  margin: auto;

  padding: 100px;

  background-color: #DDEDE9;
}


.section__container {
  max-width:70%;
  margin: auto;
 
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
  border-radius: 0.8rem;
  transition: 0.3s;
  cursor: pointer;
}

.btn:hover {
  background-color: var(--primary-color-dark);
}

img {
  display: flex;
  width: 100%;
  max-height: 500px;
  border-radius: 0.8rem;
  object-fit: cover;
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

.deals__container .tab__content {
  display: grid;
}

.deals__card {
  padding: 1rem;
  background-color: #F0FAF6;
  border-radius: 2rem;
  box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
}

.deals__card img {
  margin-bottom: 1rem;
  border-radius: 0.8rem;
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