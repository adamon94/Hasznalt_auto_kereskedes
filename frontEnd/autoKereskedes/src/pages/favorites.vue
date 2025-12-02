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

/*const removeFromFavorites = async (favId) => {
    try {
        const res = await fetch(`http://localhost:3300/cars/removeFav/${favId}`, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            }
        });
        if (res.status === 200) {
            console.log('Sikeres törlés a kedvencek közül');
           // getFavs();
            
        } else {
            console.error('Hiba történt a törlés során');
        }
    } catch (err) {
        console.error(err);
    }
};*/

onMounted(()=>{
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
            <FavCard v-for="f in myFavs" :key="f.id" 
            :car="f" 
            :likes="countLikes(f.autoId)"
            :favId="f.id"
            :refresh-favs="getMyFavs"
            />
        </section>
    </div>
</div>
</template>

<style scoped>
.favPage{
    min-height:100vh;
    width:100%;
    background-color: #DDEDE9;
}
.favContainer{
    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:center;
    
}
.pageTitle{
    
    font-weight:600;
    color: #213333;
    padding: 20px 150px;
    border-bottom: #6D8282 3px solid;
}
.favSection{
    display:flex;
    flex-wrap:wrap;
    justify-content:center;
    gap:30px;
    padding:40px;
}
</style>