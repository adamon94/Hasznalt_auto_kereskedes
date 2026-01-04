<script setup>
import { useController } from "../stores/UIcontrol"
import Head from '../components/Head.vue';
import { onMounted } from "vue";
import { useMotion } from '@vueuse/motion'

const store = useController()

</script>
<template>
    <div class="homeContainer"> <!-- HERO -->
        <section class="heroBox">
            <h1>Üdvözlünk az Autókereskedésben!</h1>
            <p>Találd meg álmaid autóját vagy intézd ügyeidet egyszerűen.</p>
            <div class="heroButtons"> <button class="navBtn" @click="router.push('/cars')">Kínálat megtekintése</button>
                <button class="navBtn" @click="router.push('/contact')">Kapcsolat</button>
            </div>
        </section> <!-- KIEMELT AUTÓ (statikus verzió) -->
        <section class="featuredCar darkBackground">
            <h2 style="color: #333;">Kiemelt ajánlatunk</h2>
            <div class="carCard"> <img src="../assets/bmw-3-series-front-720x405px.jpg"
                    alt="Kiemelt autó">
                <div class="carInfo">
                    <h3>BMW 3-as széria</h3>
                    <p>Érdeklődjön most!</p> <button class="navBtn"
                        @click="router.push('/cars')">Megtekintés</button>
                </div>
            </div>
        </section> <!-- SZOLGÁLTATÁS KÁRTYÁK -->
        <section class="cardsSection darkBackground">
            <div class="infoCard">
                <h2>Szolgáltatásaink</h2>
                <p>Tesztvezetések, beszámítás, finanszírozás és még sok más.</p> <button class="navBtn"
                    @click="router.push('/about')">Tovább</button>
            </div>
            <div class="infoCard">
                <h2>Fiók funkciók</h2>
                <p>Kedvencek, kívánságlista, tesztvezetések kezelése.</p> <button class="navBtn"
                    @click="router.push('/kedvencek')">Megnyitás</button>
            </div>
            <div class="infoCard">
                <h2>Kapcsolat</h2>
                <p>Vedd fel velünk a kapcsolatot bármikor.</p> <button class="navBtn"
                    @click="router.push('/contact')">Elérhetőségek</button>
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
}

.carInfo {
    flex: 1;
    text-align: left;
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

/* MOBIL RESZPONZÍV */
@media (max-width: 900px) {
    .cardsSection {
        flex-direction: column;
    }

    .carCard {
        flex-direction: column;
    }

    .carCard img {
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
