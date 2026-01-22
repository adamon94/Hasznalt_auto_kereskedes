<template>
<div class="container">
   
      <h3 class="mb-4">
        kívánság felvétel:
      </h3>
    <div class="card-body">
      <form @submit.prevent="handleSubmit">
        <div class="mb-4">
          <label for="model" class="form-label fw-semibold">
            <i class="bi bi-car-front me-1"></i>Keresett model:
          </label>
          <input 
            type="text" 
            id="model"
            v-model="formData.model"
            class="form-control form-control-lg" 
            placeholder="Pl.: Audi, BMW, Mercedes..."
          >   
        </div>

        <div class="mb-4">
          <label for="performance" class="form-label fw-semibold">
           Keresett teljesítmény (cm³):
          </label>
          <div class="input-group input-group-lg">
            <span class="input-group-text">Több mint</span>
            <input 
              type="number" 
              id="performance"
              v-model.number="formData.performance"
              class="form-control" 
              placeholder="1600"
            >
            <span class="input-group-text">cm³</span>
          </div>
        </div>
        
        <div class="mb-4">
          <label for="consumption" class="form-label fw-semibold">
            <i class="bi bi-fuel-pump me-1"></i>Kívánt fogyasztás:
          </label>
          <div class="input-group input-group-lg">
            <span class="input-group-text">Kevesebb mint</span>
            <input 
              type="number" 
              id="consumption"
              v-model.number="formData.consumption"
              class="form-control" 
              placeholder="8.5"
              step="0.1"
            >
            <span class="input-group-text">l/100km</span>
          </div>
        </div>


        <div class="mb-4">
          <label for="price" class="form-label fw-semibold">
            <i class="bi bi-currency-exchange me-1"></i>Kívánt ár:
          </label>
          <div class="input-group input-group-lg">
            <span class="input-group-text">Kevesebb mint</span>
            <input 
              type="number" 
              id="price"
              v-model.number="formData.price"
              class="form-control" 
              placeholder="5000000"
            >
            <span class="input-group-text">Ft</span>
          </div>
        </div>

        <div class="mb-4">
          <label for="carType" class="form-label fw-semibold">
            <i class="bi bi-collection me-1"></i>Keresett típus:
          </label>
          <select id="carType" v-model="formData.carType" class="form-select form-select-lg">
            <option value="">Válassz típust...</option>
            <option value="SUV">SUV / Terepjáró</option>
            <option value="Sedan">Sedan</option>
            <option value="Kombi">Kombi</option>
            <option value="Hatchback">Hatchback</option>
            <option value="Coupe">Coupe</option>
            <option value="Luxus autó">Luxus autó</option>
          </select>
        </div>

        <div class="mb-4">
          <label for="transmission" class="form-label fw-semibold">
            <i class="bi bi-gear me-1"></i>Sebességváltó:
          </label>
          <select id="transmission" v-model="formData.transmission" class="form-select form-select-lg">
            <option value="">Válassz váltót...</option>
            <option value="Automata">Automata</option>
            <option value="Manuális">Manuális</option>
            <option value="Félautomata">Félautomata</option>
          </select>
        </div>


        <div class="mb-4">
          <label for="fuelType" class="form-label fw-semibold">
            <i class="bi bi-droplet me-1"></i>Üzemanyag:
          </label>
          <select id="fuelType" v-model="formData.fuelType" class="form-select form-select-lg">
            <option value="">Válassz üzemanyagot...</option>
            <option value="Benzin">Benzin</option>
            <option value="Dízel">Dízel</option>
            <option value="Elektromos">Elektromos</option>
            <option value="Hibrid">Hibrid</option>
          </select>
        </div>
    
          <button type="submit" class="btn btn-primary btn-lg">
            Kívánság hozzáadása
          </button>
      </form>
    </div>
</div>
</template>

<script setup>
import { reactive } from 'vue';

const emit = defineEmits(['add-wish']);

const formData = reactive({
  model: '',
  performance: null,
  consumption: null,
  price: null,
  carType: '',
  transmission: '',
  fuelType: ''
});

const handleSubmit = () => {
  const hasData = Object.values(formData).some(value => {
      return value !== '' && value !== null && value !== undefined;
  });

  if (!hasData) {
      console.log("Üres űrlap, nem küldünk semmit.");
      return; 
  }

  emit('add-wish', { ...formData });

};
</script>

<style scoped>
h3{
    font-weight: 500;
    text-align: center;
    border-bottom: 3px solid #C8BCCF;
    padding: 10px;
    padding-bottom: 25px;
}
.form-label {
  color: #495057;
  font-size: 1.3rem;
  margin-bottom: 0.5rem;
}
.input-group-text {
  color: #6c757d;
  font-weight: 500;
}
.form-control {
  background-color: #F8F5FA;
}
.btn {
  border-radius: 8px;
  font-weight: 600;
  padding: 0.75rem 1.5rem;
}
.btn-primary {
  background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
  border: none;
}
input::placeholder {
  color: #adb5bd;
  font-style: italic;
}
select.form-select {
  background-color: #F8F5FA;
}
</style>