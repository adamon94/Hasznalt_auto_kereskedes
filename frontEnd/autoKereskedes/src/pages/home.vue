<script setup>
import { useController } from "../stores/UIcontrol"
import Head from '../components/Head.vue';
import { onMounted, ref } from "vue";
import { useRouter } from 'vue-router';

const router = useRouter()
const useStore = useController();
const store = useController()

const featuredCar = ref(null);
const loadingFeatured = ref(true);

const getImageUrl = (path) => {
  if (!path) return 'https://via.placeholder.com/600x300?text=Nincs+kep';
  try {
    return new URL(`../assets/${path}`, import.meta.url).href;
  } catch (error) {
    return `http://localhost:3300/images/${path}`;
  }
};

const fetchFeaturedCar = async () => {
    try {
        const res = await fetch('http://localhost:3300/cars/getCars');
        const allCars = await res.json();
        if (allCars && allCars.length > 0) {
            const randomIndex = Math.floor(Math.random() * allCars.length);
            featuredCar.value = allCars[randomIndex];
        }
        
        if (!res.ok) throw new Error('Hiba a kiemelt autó betöltésekor');
        
        const data = await res.json();
        
        if (data && data.id) {
            featuredCar.value = data;
        } else {
            console.log("Nincs meg a kiemelt autó (ID 1)");
        }

    } catch (error) {
        console.error(error);
    } finally {
        loadingFeatured.value = false;
    }
};

onMounted(() => {
    fetchFeaturedCar();
});

</script>

<template>
    <div class="homeContainer">
        <section class="heroBox">
            <h1>Üdvözlünk az Autókereskedésben!</h1>
            <p>Találd meg álmaid autóját vagy intézd ügyeidet egyszerűen.</p>
            <div class="heroButtons"> 
                <button class="navBtn" @click="router.push('/cars')">Kínálat megtekintése</button>
                <button class="navBtn" @click="router.push('/contact')">Kapcsolat</button>
            </div>
        </section> 

        <section class="featuredCar darkBackground">
            
            <div class="carCard" v-if="!loadingFeatured && featuredCar">
                <img :src="getImageUrl(featuredCar.Images[0]?.path)" alt="Kiemelt autó">
                <div class="carInfo">
                    <h2 style="color: #333;">Kiemelt ajánlatunk</h2>
                    <h3>{{ featuredCar.model }}</h3>
                    <p>Ár: {{ featuredCar.ar ? featuredCar.ar.toLocaleString() + ' Ft' : 'Egyeztetés alatt' }}</p>
                    <p>Típus: {{ featuredCar.tipus }}</p>
                    <button class="navBtn"
                        @click="router.push({ name: 'carDetails', params: { id: featuredCar.id } })">
                        Megtekintés
                    </button>
                </div>
            </div>

            <div v-else class="carCard">
                <img src="../assets/bmw-3-series-front-720x405px.jpg" alt="Helyettesítő kép">
                <div class="carInfo">
                    <h3>Hirdetés betöltése...</h3>
                    <p>Kérjük, várjon.</p>
                </div>
            </div>
        </section> 

        <section class="cardsSection darkBackground">
            <div class="infoCard">
                <h2>Rólunk</h2>
                <p>Miért pont a Második Kör? Itt megtudod.</p> 
                <button class="navBtn" @click="router.push('/us')">Tovább</button>
            </div>
            <div class="infoCard">
                <h2>Pénzügy</h2>
                <p>Vásárlási és finanszírozási információk.</p> 
                <button class="navBtn" @click="router.push('/finance')">Megnyitás</button>
            </div>
            <div class="infoCard">
                <h2>Kapcsolat</h2>
                <p>Vedd fel velünk a kapcsolatot bármikor.</p> 
                <button class="navBtn" @click="router.push('/contact')">Elérhetőségek</button>
            </div>
        </section>

        <section class="bottomSection darkBackground">
            <div class="bottomContent">
                <div class="promoText">
                    <h2>Miért válasszon minket?</h2>
                    <p>
                        A Második Kör Autókereskedésben elkötelezettek vagyunk a kiváló minőség és a vásárlói elégedettség iránt. Minden járművet alapos szakmai vizsgának vetünk alá, hogy biztosíthassuk Önnek a megbízhatóságot. Széles választékunkban megtalálja az ideális autót, legyen az családi használatra vagy városi közlekedésre. Vállalunk országos garanciát és rugalmas finanszírozási megoldásokat is!
                    </p>
                </div>
                <div class="contactInfo">
                    <h3>Elérhetőségeink</h3>
                    <div class="contactItem"><i class="ri-map-pin-line"></i> 1106 Budapest, Kerepesi út 120/B.</div>
                    <div class="contactItem"><i class="ri-phone-line"></i> +36 30 123 4567</div>
                    <div class="contactItem"><i class="ri-mail-line"></i> info@masodikkor.hu</div>
                    <button class="navBtn" @click="router.push('/contact')" style="margin-top: 15px; width: 100%;">Írj nekünk</button>
                </div>
            </div>
        </section>
    </div>
</template>

<style scoped>
:global(body) {
    background-color: #DDEDE9 !important;
}

.homeContainer {
    width: 80%;
    margin: auto;
    padding-top: 40px;
    padding-bottom: 50px;
}

.heroBox {
    background-color: #D0D8D9;
    padding: 40px;
    border-radius: 15px;
    text-align: center;
    color: #333;
    box-shadow: none;
}

.heroButtons {
    display: flex;
    justify-content: center;
    gap: 1.5rem;
    margin-top: 20px;
}

.navBtn {
    text-decoration: none;
    font-size: medium;
    font-weight: bold;
    color: #333;
    background-color: #C8BCCF;
    border: none;
    border-radius: 10px;
    padding: 10px 28px;
    cursor: pointer;
    transition: all 0.3s ease;
}

.navBtn:hover {
    background-color: #A3C9C4;
    color: #fff;
    transform: translateY(-2px);
}

.featuredCar {
    margin-top: 50px;
    text-align: center;
}

.carCard {
    margin-top: 20px;
    background-color: #D0D8D9;
    border-radius: 15px;
    padding: 20px;
    display: flex;
    gap: 20px;
    align-items: center;
    box-shadow: none;
    color: #333;
}

.carCard img {
    width: 45%;
    border-radius: 12px;
    object-fit: cover;
    height: 300px; 
}

.carInfo {
    flex: 1;
    text-align: left;
}

.carInfo p {
    margin: 10px 0;
    font-size: 1.1rem;
    font-weight: 500;
}

.cardsSection {
    margin-top: 50px;
    display: flex;
    justify-content: space-between;
    gap: 2rem;
}

.infoCard {
    flex: 1;
    background-color: #D0D8D9;
    padding: 25px;
    border-radius: 15px;
    box-shadow: none;
    text-align: center;
    color: #333;
}

.bottomSection {
    margin-top: 50px;
    background-color: #D0D8D9;
    border-radius: 15px;
    padding: 30px;
}

.bottomContent {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 3rem;
}

.promoText {
    flex: 2;
    text-align: left;
}

.promoText p {
    line-height: 1.6;
    color: #333;
    margin-top: 10px;
}

.contactInfo {
    flex: 1;
    text-align: left;
    background-color: rgba(255, 255, 255, 0.4);
    padding: 20px;
    border-radius: 10px;
}

.contactItem {
    margin: 10px 0;
    display: flex;
    align-items: center;
    gap: 10px;
    font-weight: 600;
    color: #333;
}

.contactItem i {
    font-size: 1.2rem;
    color: #333;
}

@media (max-width: 900px) {
    .cardsSection, .bottomContent {
        flex-direction: column;
    }

    .carCard {
        flex-direction: column;
    }

    .carCard img {
        width: 100%;
    }

    .promoText, .contactInfo {
        width: 100%;
    }
}

@media (max-width: 600px) {
    .heroBox {
        padding: 25px;
    }

    .navBtn {
        padding: 8px 20px;
    }

    .homeContainer {
        width: 95%;
    }
}
</style>