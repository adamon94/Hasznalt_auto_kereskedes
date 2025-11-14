<script setup>
import { ref } from 'vue';
import WishForm from '../components/wishComps/wishForm.vue';
import WishList from '../components/wishComps/wishList.vue';
import FavCard from '../components/favCard.vue';

const matches = ref([]);

</script>

<template>
<div class="wishesPage">
    <div class="pageTitle">
        <h1>Kívánságlistám</h1>
    </div>
    <div class="wishesContent">
       <section class="addWish">
           <WishForm/>
        </section>
       <section class="wishesList">
           <WishList/>
       </section>
    </div>
</div>
<footer class="matches">
<div class="matchesList" v-if="matches.length">
    <h2>Találatok a kívánságaid alapján:</h2>
<FavCard v-for="match in matches" :key="match.id" :car="match" />
</div>
<div v-else class="noMatches">
    <h2>Nincsenek találatok a kívánságaid alapján.</h2>
</div>
</footer>

</template>

<style scoped>
.wishesPage{
background-color: #DDEDE9;
}
.pageTitle{
    position: relative;
    display: flex;
    justify-content: center;
    padding: 2rem 0;
    right: 60px;
    top: 35px;
   
}
.wishesContent{
    display: grid;
    grid-template-columns: 50% 50%;
    justify-items: center;
    margin-top: 20px;
    padding-bottom: 30px;
}


.addWish{
    margin: 50px 0 0 50px;
    border-right: 3px solid #DCE3E8;
    padding: 15px 4.5rem 0 0rem;
}

.wishesList{
    margin: 50px 0 0 0;
    padding: 10px 5rem 0 0rem;
}
.matches{
    background-color: #F8F5FA;
    padding: 30px 0;

}
.matchesList{
    display: flex;
    flex-wrap: wrap;
    margin: 30px 0 0 30px;
    text-align: center;
}
.matchesList h2{
   text-align: center;
    margin-bottom: 20px;
    font-weight: 500;
    width: fit-content;
    border-bottom: 3px solid #DCE3E8;
}
.noMatches h2{
    text-align: center;
    font-weight: 500;
    margin-top: 20px;
}

</style>