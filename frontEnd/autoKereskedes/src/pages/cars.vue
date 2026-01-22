<script setup>
import { onMounted, ref } from 'vue';

const cars = ref([])
const priceRange = ref([0, 200_000_000]) 
const yearRange = ref([1990, 2024]) 
const fuelType = ref(null) 
const gearbox = ref(null)

const formatNumber = (number) => {
  return new Intl.NumberFormat('hu-HU', { style: "currency", currency: "HUF" }).format(number);
}

const refreshPage = () => {
  window.location.reload();
}

const selectedBrand = ref(null)

onMounted(() => {
  fetch("http://localhost:3300/cars/getCars").then(async (res) => {
    const data = await res.json();
    cars.value = data;
    console.log(cars.value)
  });
})

import { computed } from 'vue'

const filteredCars = computed(() => {
  return cars.value
    .filter(car => !selectedBrand.value || car.marka === selectedBrand.value)
    .filter(car => car.ar >= priceRange.value[0] && car.ar <= priceRange.value[1])
    .filter(car => car.gyartasEve >= yearRange.value[0] && car.gyartasEve <= yearRange.value[1])
    .filter(car => !fuelType.value || car.uzemAnyagTipus === fuelType.value)
    .filter(car => !gearbox.value || car.sebessegValtoRendszer === gearbox.value)
})

console.log(filteredCars.value);
console.log(yearRange.value[0]);
console.log(yearRange.value[1]);

</script>



<template>
  <section>
    <div class="section__container deals__container">
      <h2 class="section__header">A legnépszerűbb autókölcsönzési ajánlatok</h2>
      <p class="section__description">
        Fedezze fel legjobb autókölcsönzési ajánlatainkat, amelyeket gondosan válogattunk össze, hogy a legjobb árat és élményt nyújtsuk Önnek. Foglaljon most, és vezesse kedvenc autóját hihetetlen áron!
      </p>
      <div class="deals__tabs">
        <button class="btn" @click="selectedBrand = 'Suzuki'">Suzuki</button>
        <button class="btn" @click="selectedBrand = 'Citroen'">Citroen</button>
        <button class="btn" @click="selectedBrand = 'BMW'">BMW</button>
        <button class="btn" @click="selectedBrand = 'Toyota'">Toyota</button>
        <button class="btn" @click="selectedBrand = 'Opel'">Opel</button>
        <button class="btn" @click="selectedBrand = 'Volkswagen'">Volkswagen</button>
      </div>

      <button class="btn refresh-btn" @click="refreshPage">
            <i class="ri-refresh-line"></i> Frissítés
          </button>

      <div class="filter-panel">
        <h3>Szűrés paraméterek alapján</h3> <label>Ár (HUF): {{ priceRange[0] }} - {{ priceRange[1]
          }}</label> <input type="range" min="0" max="15000000" v-model="priceRange[0]"> <input type="range" min="0"
          max="15000000" v-model="priceRange[1]"> <label>Évjárat: {{ yearRange[0] }} - {{
            yearRange[1] }}</label> <input type="range" min="1990" max="2024" v-model="yearRange[0]"> <input type="range"
          min="1990" max="2024" v-model="yearRange[1]"> <label>Üzemanyag</label> <select
          v-model="fuelType">
          <option value="">Mind</option>
          <option value="Benzin">Benzin</option>
          <option value="Dízel">Dízel</option>
          <option value="Hybrid">Hybrid</option>
          <option value="Elektromos">Elektromos</option>
        </select> <label>Váltó</label> <select v-model="gearbox">
          <option value="">Mind</option>
          <option value="Manuális">Manuális</option>
          <option value="Automata">Automata</option>
        </select>
      </div>

      <div class="tab__content">
        <div v-for="car in filteredCars" :key="car.id" class="deals__card mb-4">
          <img :src="'http://localhost:3300/images/' + car.Images[0]?.path" alt="Deals" />
          <h4>{{ car.model }}</h4>
          <div class="deals__card__grid">
            <div>
              <span><i class="ri-group-line"></i></span> Férőhley: {{ car.ferohely }}
            </div>
            <div>
              <span><i class="ri-steering-2-line"></i></span> Váltó rendszer: {{ car.sebessegValtoRendszer }}
            </div>
            <div>
              <span><i class="ri-speed-up-line"></i></span> henger űrtartalom: {{ car.hengerUrTartalom }} cm³
            </div>
            <div>
              <span><i class="ri-car-line"></i></span> Üzemanyag: {{ car.uzemAnyagTipus }}
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
section {
  margin: auto;

  padding: 100px;

  background-color: #DDEDE9;
}


.section__container {
  max-width: 70%;
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

.filter-panel {
  background: #F0FAF6;
  padding: 1.5rem;
  border-radius: 1rem;
  margin-bottom: 2rem;
  display: grid;
  gap: 1rem;
}

.filter-panel label {
  font-weight: bold;
  color: #333;
}

.filter-panel input[type="range"] {
  width: 100%;
}

.filter-panel select {
  padding: 0.5rem;
  border-radius: 0.5rem;
  border: 1px solid #ccc;
}
</style>