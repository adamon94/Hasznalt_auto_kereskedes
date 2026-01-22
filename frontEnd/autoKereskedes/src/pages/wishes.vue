<script setup>
import { ref, computed, onMounted } from 'vue';
import WishForm from '../components/wishComps/wishForm.vue';
import WishList from '../components/wishComps/wishList.vue';
import FavCard from '../components/favCard.vue';

const wishes = ref([]);
const carsOffer = ref([]);
const allFavs = ref([]);
const loading = ref(true);
const errorMessage = ref('');

const fetchCars = async () => {
    try {
        const res = await fetch('http://localhost:3300/cars/getCars');
        if (!res.ok) throw new Error(`Szerver hiba: ${res.status}`);
        const data = await res.json();
        if (Array.isArray(data)) carsOffer.value = data;
        else console.error('Nem várt adatformátum:', data);
    } catch (error) {
        console.error('Hiba:', error);
        errorMessage.value = `Hiba: ${error.message}`;
    } finally {
        loading.value = false;
    }
};


const getAllFavs = async () => {
    const res = await fetch(`http://localhost:3300/cars/allFavs`);
    const data = await res.json();
    allFavs.value = data;
};

onMounted(() => {
    fetchCars();
    getAllFavs();
});

const countLikes = (carId) => {
    let count = 0;
    allFavs.value.forEach(fav => {
        if (fav.autoId === carId) {
            count++;
        }
    });
    return count;
};

const matches = computed(() => {
    if (loading.value) return [];
    if (!Array.isArray(carsOffer.value)) return [];
    if (wishes.value.length === 0) return [];

    return carsOffer.value.filter(car => {
        return wishes.value.some(wish => {
            const modelOk = !wish.model || (car.model && car.model.toLowerCase().includes(wish.model.toLowerCase()));
            const priceOk = !wish.price || (car.ar && car.ar <= wish.price);
            const consOk = !wish.consumption || (car.fogyasztas && car.fogyasztas <= wish.consumption);
            const perfOk = !wish.performance || (car.hengerUrTartalom && car.hengerUrTartalom >= wish.performance);
            const typeOk = !wish.carType || (car.tipus && car.tipus === wish.carType);
            const transOk = !wish.transmission || (car.sebessegValtoRendszer && car.sebessegValtoRendszer === wish.transmission);
            const fuelOk = !wish.fuelType || (car.uzemAnyagTipus && car.uzemAnyagTipus === wish.fuelType);

            return modelOk && priceOk && consOk && perfOk && typeOk && transOk && fuelOk;
        });
    });
});

const addWish = (wish) => {
    wishes.value.push({ id: Date.now(), ...wish });
};

const removeWish = (id) => {
    wishes.value = wishes.value.filter(w => w.id !== id);
};
</script>

<template>
    <div class="wishesPage">
        <div class="pageTitle">
            <h1>Kívánságlistám</h1>
        </div>
        <div class="wishesContent">
            <section class="addWish">
                <WishForm @add-wish="addWish" />
            </section>
            <section class="wishesList">
                <WishList :wishes="wishes" @remove-wish="removeWish" />
            </section>
        </div>
    </div>

    <footer class="matches">
        <div class="matchesList">
            <div v-if="errorMessage" class="error-message">
                <h3>Hiba történt!</h3>
                <p>{{ errorMessage }}</p>
                <button @click="fetchCars" class="retry-btn">Újra próbálkozás</button>
            </div>

            <div v-else-if="loading" style="text-align: center; width: 100%; padding: 20px;">
                <p>Autók betöltése...</p>
            </div>

            <div v-else-if="matches.length">
                <h2>Találatok a kívánságaid alapján:</h2>
                <div class="cards-container">
                    <FavCard v-for="match in matches" :key="match.id" :car="match" :likes="countLikes(match.id)"
                        :favId="match.id" />
                </div>
            </div>

            <div v-else class="noMatches">
                <h2 v-if="wishes.length === 0">Adj meg kívánságot a kereséshez!</h2>
                <h2 v-else>Nincsenek találatok a kívánságaid alapján.</h2>
            </div>
        </div>
    </footer>
</template>

<style scoped>
.wishesPage {
    background-color: #DDEDE9;
}

.pageTitle {
    position: relative;
    display: flex;
    justify-content: center;
    padding: 2rem 0;
    right: 60px;
    top: 35px;
}

.wishesContent {
    display: grid;
    grid-template-columns: 50% 50%;
    justify-items: center;
    margin-top: 20px;
    padding-bottom: 30px;
}

.addWish {
    margin: 50px 0 0 50px;
    border-right: 3px solid #DCE3E8;
    padding: 15px 4.5rem 0 0rem;
}

.wishesList {
    margin: 50px 0 0 0;
    padding: 10px 5rem 0 0rem;
}

.matches {
    background-color: #F8F5FA;
    padding: 30px 0;
}

.matchesList {
    display: flex;
    flex-wrap: wrap;
    margin: 30px 0 0 30px;
    text-align: center;
}

.cards-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
    width: 100%;
}

.matchesList h2 {
    text-align: center;
    margin-bottom: 20px;
    font-weight: 500;
    width: fit-content;
    border-bottom: 3px solid #DCE3E8;
    margin-left: auto;
    margin-right: auto;
}

.noMatches h2 {
    text-align: center;
    font-weight: 500;
    margin-top: 20px;
}

.error-message {
    background-color: #ffebee;
    color: #c62828;
    padding: 20px;
    border-radius: 8px;
    border: 1px solid #ef9a9a;
    width: 100%;
    max-width: 500px;
    margin: 0 auto;
    text-align: center;
}

.retry-btn {
    margin-top: 10px;
    padding: 8px 16px;
    background-color: #c62828;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.retry-btn:hover {
    background-color: #b71c1c;
}
</style>