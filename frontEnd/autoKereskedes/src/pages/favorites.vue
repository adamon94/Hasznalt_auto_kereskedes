<script setup>
import { onMounted } from 'vue';
import FavCard from '../components/favCard.vue';
import { useController } from '../stores/UIcontrol';
import { ref } from 'vue';

const myFavs = ref([])
const allFavs = ref([])

const getAllFavs = async () => {
    const res = await fetch(`http://localhost:3300/cars/allFavs`)
    const data = await res.json();
    allFavs.value = data;
    console.log(allFavs.value)
};
const getMyFavs = async () => {
    const res = await fetch(`http://localhost:3300/cars/userFavorites/${store.id}`)

    const data = await res.json();
    myFavs.value = data;
    console.log(myFavs.value)
};

const countLikes = (carId) => {
    let count = 0;
    allFavs.value.forEach(fav => {
        if (fav.autoId === carId) {
            count++;
        }
    });
    return count;
};


onMounted(() => {
    getMyFavs();
    getAllFavs();
})

const store = useController();
</script>


<template>
    <div class="favPage">
        <div class="favContainer">
            <h1 class="pageTitle mt-4">Általam kedvelt autók</h1>
            <section class="favSection">
                <FavCard v-for="f in myFavs" :key="f.id" :car="f" :likes="countLikes(f.autoId)" :favId="f.id"
                    :refresh-favs="getMyFavs" />
            </section>
        </div>
    </div>
</template>

<style scoped>
.favPage {
    min-height: 100vh;
    width: 100%;
    background-color: #DDEDE9;
}

.favContainer {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;

}

.pageTitle {

    font-weight: 600;
    color: #213333;
    padding: 20px 150px;
    border-bottom: #6D8282 3px solid;
}
.favSection {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 30px;
    padding: 40px;
    justify-items: center;
}

@media (max-width: 900px) {
    .favSection {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 600px) {
    .favSection {
        grid-template-columns: 1fr;
    }
}
</style>