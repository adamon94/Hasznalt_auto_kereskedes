<script setup>
import { defineProps } from 'vue';
import { useRouter } from 'vue-router';
const router = useRouter();
const props = defineProps({
  car: {
    type: Object,
    required: true
  },
  likes: {
    type: Function,
    required: false
  },
  favId: {
    type: Number,
    required: false
  },

  refreshFavs: {
    type: Function,
    required: false
  }
});

const getMyFavs = () => {
    if (props.refreshFavs) {
        props.refreshFavs();
    }
};

const removeFromFavorites = async (favId) => {
    try {
        const res = await fetch(`http://localhost:3300/cars/removeFav/${favId}`, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            }
        });
        if (res.status === 200) {
            console.log('Sikeres törlés a kedvencek közül');
            getMyFavs();
            
        } else {
            console.error('Hiba történt a törlés során');
        }
    } catch (err) {
        console.error(err);
    }
};


/*
Nested data structure example: Autok.models, Autok.Images[0].path
*/
</script>


<template>
    <div class="card">
 <div class="badge"><i class="ri-heart-pulse-fill"></i><i class="ri-heart-pulse-fill"></i><i class="ri-heart-pulse-fill"></i></div>
 <div class="tilt">
  <div class="img"><img :src="'http://localhost:3300/images/' + car.Autok.Images[0]?.path" alt="Premium Laptop"></div>
 </div>
 <div class="info">
  <div class="cat">{{ car.Autok.tipus }}</div>
  <h2 class="title">{{ car.Autok.model }}</h2>
  <div class="feats">
   <span class="feat">Fő: {{ car.Autok.ferohely }}</span>
   <span class="feat">Üzemanyag: {{ car.Autok.uzemAnyagTipus }}</span>
   <span class="feat">Váltó: {{ car.Autok.sebessegValtoRendszer }}</span>
  </div>
  <div class="bottom">
   <div class="price">
    <span class="new">{{ car.Autok.ar }} Ft</span>
   </div>
   <button @click="router.push({ name: 'carDetails', params: { id: car.Autok.id } })" class="btn">
    <span>Az adatlapra</span>
    <i class="ri-arrow-right-line"></i>
   </button>
  </div>
  <div class="meta">
   <div class="rating">
    
    <i class="ri-hearts-fill"></i>
    <span class="rcount">{{ likes }} Kedvelés</span>
   </div>
   <button class="btn" @click="removeFromFavorites(props.favId)">Törlöm</button>
  </div>
 </div>
</div>
</template>

<style scoped>

.card
{
    width:220px;
    /*height: 320px;*/
    background:#fff;
    border-radius:15px;
    box-shadow:0 5px 20px rgba(0,0,0,.1);
    transition:.3s;
    overflow:hidden;
    position:relative;
    cursor:pointer;
    background-color: #EBDDE2;
}
.card:hover{
    transform:translateY(-5px);
    box-shadow:0 10px 25px rgba(0,0,0,.15)
}
.badge{
    position:absolute;
    top:10px;
    right:10px;
    background: linear-gradient(to right,  rgba(169,3,41,1) 0%,rgba(196,72,72,1) 44%,rgba(170,34,56,1) 100%);
    color:#fff;padding:5px 10px;font-size:11px;
    font-weight:600;
    letter-spacing:1px;
    text-transform:uppercase;
    border-radius:10px;
    box-shadow:0 3px 10px rgba(0,0,0,.2);
    z-index:10}
 /* .tilt{
  overflow:hidden
}*/
/*.img{
    height:200px;
    overflow:hidden
}*/
.img img{
    width:100%;
    height:140px;
    object-fit:cover;
    transition:transform .5s
}
.card:hover .img img{
    transform:scale(1.05)
}
.info{
    padding:10px;
    
}
.cat{
    font-size:11px;
    font-weight:600;
    letter-spacing:1px;
    text-transform:uppercase;
    color:#71717A;
    margin-bottom:5px
}
.title{
    font-size:18px;
    font-weight:700;
    color:#18181B;
    margin:0 0 10px;
    letter-spacing:-.5px
}
.desc{
    font-size:13px;
    color:#52525B;
    line-height:1.4;
    margin-bottom:12px
}
.feats{
    display:flex;
    gap:6px;
    margin-bottom:5px
}
.feat{
    font-size:10px;
    background:#F4F4F5;
    color:#71717A;
    padding:3px 8px;
    border-radius:10px;
    font-weight:500
}
.bottom{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:12px;
    margin-top:10px;
}
.price{
    display:flex;
    flex-direction:column
}
.old{
    font-size:13px;
    text-decoration:line-through;
    color:#A1A1AA;
    margin-bottom:2px
}
.new{
    font-size:20px;
    font-weight:700;
    color:#18181B
}
.btn{
    background:linear-gradient(45deg,#18181B,#27272A);
    color:#fff;
    border:none;
    border-radius:10px;
    padding:8px 5px;
    font-size:13px;
    font-weight:600;
    cursor:pointer;
    display:flex;
    align-items:center;
    gap:6px;
    transition:.3s;
    box-shadow:0 3px 10px rgba(0,0,0,.1)
}
.btn:hover{
    background:linear-gradient(45deg,#27272A,#3F3F46);
    transform:translateY(-2px);
    box-shadow:0 5px 15px rgba(0,0,0,.15)
}
.btn:before{content:'';
position:absolute;
top:0;
left:-100%;
width:100%;
height:100%;
background:linear-gradient(90deg,transparent,rgba(255,255,255,.1),transparent);
transition:.5s
}
.btn:hover:before{left:100%}
.icon{transition:transform .3s}
.btn:hover .icon{transform:rotate(-10deg) scale(1.1)}
.meta{
    display:flex;
    justify-content:space-between;
    align-items:center;
    border-top:1px solid #F4F4F5;
    padding-top:6px
}
.rating{
    display:flex;
    align-items:center;
    gap:2px
}
.rcount{
    margin-left:6px;
    font-size:11px;
    color:#71717A
}
.stock{
    font-size:11px;
    font-weight:600;
    color:#22C55E
}

@media (max-width:400px){.card{width:90%}.title{font-size:16px}.img{height:180px}.bottom{flex-direction:column;align-items:flex-start;gap:10px}.price{margin-bottom:5px}.btn{width:100%;justify-content:center}}

</style>