<script setup>
import {useController} from "../stores/UIcontrol"
import Head from '../components/Head.vue';
import { onMounted } from "vue";

const store = useController()

let menu = document.querySelector('#menu-btn');
let navbar = document.querySelector('.navbar');

menu.onclick = () =>{
  menu.classList.toggle('fa-times');
  navbar.classList.toggle('active');
}

document.querySelector('#login-btn').onclick = () =>{
  document.querySelector('.login-form-container').classList.toggle('active');
}

document.querySelector('#close-login-form').onclick = () =>{
  document.querySelector('.login-form-container').classList.remove('active');
}

window.onscroll = () =>{

  menu.classList.remove('fa-times');
  navbar.classList.remove('active');

  if(window.scrollY > 0){
    document.querySelector('.header').classList.add('active');
  }else{
    document.querySelector('.header').classList.remove('active');
  };

};

document.querySelector('.home').onmousemove = (e) =>{

  document.querySelectorAll('.home-parallax').forEach(elm =>{

    let speed = elm.getAttribute('data-speed');

    let x = (window.innerWidth - e.pageX * speed) / 90;
    let y = (window.innerHeight - e.pageY * speed) / 90;

    elm.style.transform = `translateX(${y}px) translateY(${x}px)`;

  });

};


document.querySelector('.home').onmouseleave = (e) =>{

  document.querySelectorAll('.home-parallax').forEach(elm =>{

    elm.style.transform = `translateX(0px) translateY(0px)`;

  });

};

var swiper = new Swiper(".vehicles-slider", {
  grabCursor: true,
  centeredSlides: true,  
  spaceBetween: 20,
  loop:true,
  autoplay: {
    delay: 9500,
    disableOnInteraction: false,
  },
  pagination: {
    el: ".swiper-pagination",
    clickable:true,
  },
  breakpoints: {
    0: {
      slidesPerView: 1,
    },
    768: {
      slidesPerView: 2,
    },
    1024: {
      slidesPerView: 3,
    },
  },
});

var swiper = new Swiper(".featured-slider", {
  grabCursor: true,
  centeredSlides: true,  
  spaceBetween: 20,
  loop:true,
  autoplay: {
    delay: 9500,
    disableOnInteraction: false,
  },
  pagination: {
    el: ".swiper-pagination",
    clickable:true,
  },
  breakpoints: {
    0: {
      slidesPerView: 1,
    },
    768: {
      slidesPerView: 2,
    },
    1024: {
      slidesPerView: 3,
    },
  },
});

var swiper = new Swiper(".review-slider", {
  grabCursor: true,
  centeredSlides: true,  
  spaceBetween: 20,
  loop:true,
  autoplay: {
    delay: 9500,
    disableOnInteraction: false,
  },
  pagination: {
    el: ".swiper-pagination",
    clickable:true,
  },
  breakpoints: {
    0: {
      slidesPerView: 1,
    },
    768: {
      slidesPerView: 2,
    },
    1024: {
      slidesPerView: 3,
    },
  },
});

</script>
<template>
 
<div class="nyitoOldal">

<header class="header">

    <section class="flex">

        <div id="menu-btn" class="fas fa-bars"></div>

        <a href="#" class="logo"> <span>max</span>wheels </a>

        <nav class="navbar">
            <a href="#home">home</a>
            <a href="#vehicles">vehicles</a>
            <a href="#services">services</a>
            <a href="#featured">featured</a>
            <a href="#reviews">reviews</a>
            <a href="#contact">contact</a>
        </nav>

        <div id="login-btn">
            <button class="btn">login</button>
            <i class="far fa-user"></i>
        </div>

    </section>

</header> 
    
<div class="login-form-container">

    <span id="close-login-form" class="fas fa-times"></span>

    <form action="">
        <h3>user login</h3>
        <input type="email" placeholder="email" class="box">
        <input type="password" placeholder="password" class="box">
        <p> forget your password <a href="#">click here</a> </p>
        <input type="submit" value="login" class="btn">
        <p>or login with</p>
        <div class="buttons">
            <a href="#" class="btn"> google </a>
            <a href="#" class="btn"> facebook </a>
        </div>
        <p> don't have an account <a href="#">create one</a> </p>
    </form>

</div>

<section class="home" id="home">

    <h3 data-speed="-2" class="home-parallax">find your car</h3>

    <img data-speed="5" class="home-parallax" src="../assets/732.jpg" alt="">

    <a data-speed="7" href="#" class="btn home-parallax">explore cars</a>

</section>

<div class="icons-container">

    <section class="box-container">

        <div class="box">
            <i class="fas fa-home"></i>
            <div class="content">
                <h3>150+</h3>
                <p>branches</p>
            </div>
        </div>
    
        <div class="box">
            <i class="fas fa-car"></i>
            <div class="content">
                <h3>4770+</h3>
                <p>cars sold</p>
            </div>
        </div>
    
        <div class="box">
            <i class="fas fa-users"></i>
            <div class="content">
                <h3>320+</h3>
                <p>happy clients</p>
            </div>
        </div>
    
        <div class="box">
            <i class="fas fa-car"></i>
            <div class="content">
                <h3>1500+</h3>
                <p>news cars</p>
            </div>
        </div>
    
    </section>

</div>

<section class="vehicles" id="vehicles">

    <h1 class="heading"> popular <span>vehicles</span> </h1>

    <div class="swiper vehicles-slider">

        <div class="swiper-wrapper">

            <div class="swiper-slide box">
                <img src="../assets/2000_Suzuki_Swift_1.3_GLX_5-door_(9754701452).jpg" alt="">
                <div class="content">
                    <h3>new model</h3>
                    <div class="price"> <span>price : </span> $62,000/- </div>
                    <p>
                        new
                        <span class="fas fa-circle"></span> 2021
                        <span class="fas fa-circle"></span> automatic
                        <span class="fas fa-circle"></span> petrol
                        <span class="fas fa-circle"></span> 183mph
                    </p>
                    <a href="#" class="btn">check out</a>
                </div>
            </div>

            <div class="swiper-slide box">
                <img src="../assets/353072_source-2048x1152.jpg" alt="">
                <div class="content">
                    <h3>new model</h3>
                    <div class="price"> <span>price : </span> $62,000/- </div>
                    <p>
                        new
                        <span class="fas fa-circle"></span> 2021
                        <span class="fas fa-circle"></span> automatic
                        <span class="fas fa-circle"></span> petrol
                        <span class="fas fa-circle"></span> 183mph
                    </p>
                    <a href="#" class="btn">check out</a>
                </div>
            </div>

            <div class="swiper-slide box">
                <img src="../assets/blog_2025_Vitara_1.png" alt="">
                <div class="content">
                    <h3>new model</h3>
                    <div class="price"> <span>price : </span> $62,000/- </div>
                    <p>
                        new
                        <span class="fas fa-circle"></span> 2021
                        <span class="fas fa-circle"></span> automatic
                        <span class="fas fa-circle"></span> petrol
                        <span class="fas fa-circle"></span> 183mph
                    </p>
                    <a href="#" class="btn">check out</a>
                </div>
            </div>

            <div class="swiper-slide box">
                <img src="../assets/bmw-3-series-front-720x405px.jpg" alt="">
                <div class="content">
                    <h3>new model</h3>
                    <div class="price"> <span>price : </span> $62,000/- </div>
                    <p>
                        new
                        <span class="fas fa-circle"></span> 2021
                        <span class="fas fa-circle"></span> automatic
                        <span class="fas fa-circle"></span> petrol
                        <span class="fas fa-circle"></span> 183mph
                    </p>
                    <a href="#" class="btn">check out</a>
                </div>
            </div>

            <div class="swiper-slide box">
                <img src="../assets/c3_3.jpg" alt="">
                <div class="content">
                    <h3>new model</h3>
                    <div class="price"> <span>price : </span> $62,000/- </div>
                    <p>
                        new
                        <span class="fas fa-circle"></span> 2021
                        <span class="fas fa-circle"></span> automatic
                        <span class="fas fa-circle"></span> petrol
                        <span class="fas fa-circle"></span> 183mph
                    </p>
                    <a href="#" class="btn">check out</a>
                </div>
            </div>

            <div class="swiper-slide box">
                <img src="../assets/IMG20240515140923.jpg" alt="">
                <div class="content">
                    <h3>new model</h3>
                    <div class="price"> <span>price : </span> $62,000/- </div>
                    <p>
                        new
                        <span class="fas fa-circle"></span> 2021
                        <span class="fas fa-circle"></span> automatic
                        <span class="fas fa-circle"></span> petrol
                        <span class="fas fa-circle"></span> 183mph
                    </p>
                    <a href="#" class="btn">check out</a>
                </div>
            </div>

        </div>

        <div class="swiper-pagination"></div>

    </div>

</section>

<section class="services" id="services">

    <h1 class="heading"> our <span>services</span> </h1>

    <div class="box-container">

        <div class="box">
            <i class="fas fa-car"></i>
            <h3>car selling</h3>
            <p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Corporis, nisi.</p>
            <a href="#" class="btn"> read more</a>
        </div>

        <div class="box">
            <i class="fas fa-tools"></i>
            <h3>parts repair</h3>
            <p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Corporis, nisi.</p>
            <a href="#" class="btn"> read more</a>
        </div>

        <div class="box">
            <i class="fas fa-car-crash"></i>
            <h3>car insurance</h3>
            <p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Corporis, nisi.</p>
            <a href="#" class="btn"> read more</a>
        </div>

        <div class="box">
            <i class="fas fa-car-battery"></i>
            <h3>battery replacement</h3>
            <p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Corporis, nisi.</p>
            <a href="#" class="btn"> read more</a>
        </div>

        <div class="box">
            <i class="fas fa-gas-pump"></i>
            <h3>oil change</h3>
            <p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Corporis, nisi.</p>
            <a href="#" class="btn"> read more</a>
        </div>

        <div class="box">
            <i class="fas fa-headset"></i>
            <h3>24/7 support</h3>
            <p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Corporis, nisi.</p>
            <a href="#" class="btn"> read more</a>
        </div>

    </div>

</section>

<section class="featured" id="featured">

    <h1 class="heading"> <span>featured</span> cars </h1>

    <div class="swiper featured-slider">

       <div class="swiper-wrapper">

            <div class="swiper-slide box">
                <img src="../assets/2000_Suzuki_Swift_1.3_GLX_5-door_(9754701452).jpg" alt="">
                <div class="content">
                    <h3>new model</h3>
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <div class="price">$55,000/-</div>
                    <a href="#" class="btn">check out</a>
                </div>
            </div>

            <div class="swiper-slide box">
                <img src="../assets/353072_source-2048x1152.jpg" alt="">
                <div class="content">
                    <h3>new model</h3>
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <div class="price">$55,000/-</div>
                    <a href="#" class="btn">check out</a>
                </div>
            </div>

            <div class="swiper-slide box">
                <img src="../assets/blog_2025_Vitara_1.png" alt="">
                <div class="content">
                    <h3>new model</h3>
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <div class="price">$55,000/-</div>
                    <a href="#" class="btn">check out</a>
                </div>
            </div>

            <div class="swiper-slide box">
                <img src="../assets/bmw-3-series-front-720x405px.jpg" alt="">
                <div class="content">
                    <h3>new model</h3>
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <div class="price">$55,000/-</div>
                    <a href="#" class="btn">check out</a>
                </div>
            </div>

       </div>

       <div class="swiper-pagination"></div>

    </div>

    <div class="swiper featured-slider">

        <div class="swiper-wrapper">
 
             <div class="swiper-slide box">
                 <img src="../assets/c3_3.jpg" alt="">
                 <div class="content">
                     <h3>new model</h3>
                     <div class="stars">
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star-half-alt"></i>
                     </div>
                     <div class="price">$55,000/-</div>
                     <a href="#" class="btn">check out</a>
                 </div>
             </div>
 
             <div class="swiper-slide box">
                 <img src="../assets/IMG20240515140923.jpg" alt="">
                 <div class="content">
                     <h3>new model</h3>
                     <div class="stars">
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star-half-alt"></i>
                     </div>
                     <div class="price">$55,000/-</div>
                     <a href="#" class="btn">check out</a>
                 </div>
             </div>
 
             <div class="swiper-slide box">
                 <img src="../assets/2000_Suzuki_Swift_1.3_GLX_5-door_(9754701452).jpg" alt="">
                 <div class="content">
                     <h3>new model</h3>
                     <div class="stars">
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star-half-alt"></i>
                     </div>
                     <div class="price">$55,000/-</div>
                     <a href="#" class="btn">check out</a>
                 </div>
             </div>
 
             <div class="swiper-slide box">
                 <img src="../assets/353072_source-2048x1152.jpg" alt="">
                 <div class="content">
                     <h3>new model</h3>
                     <div class="stars">
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star"></i>
                         <i class="fas fa-star-half-alt"></i>
                     </div>
                     <div class="price">$55,000/-</div>
                     <a href="#" class="btn">check out</a>
                 </div>
             </div>
 
        </div>
 
        <div class="swiper-pagination"></div>
 
     </div>

</section>

<div class="newsletter-container">

    <section class="newsletter">
    
        <h3>subscribe for latest updates</h3>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatum, suscipit.</p>
    
       <form action="">
            <input type="email" placeholder="enter your email">
            <input type="submit" value="subscribe">
       </form>
    
    </section>

</div>

<section class="reviews" id="reviews">

    <h1 class="heading"> client's <span>review</span> </h1>

    <div class="swiper review-slider">

        <div class="swiper-wrapper">

            <div class="swiper-slide box">
                <!-- <img src="image/pic-1.png" alt=""> -->
                <div class="content">
                    <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Ipsam incidunt quod praesentium iusto id autem possimus assumenda at ut saepe.</p>
                    <h3>john deo</h3>
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                </div>
            </div>

            <div class="swiper-slide box">
                <!-- <img src="image/pic-2.png" alt=""> -->
                <div class="content">
                    <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Ipsam incidunt quod praesentium iusto id autem possimus assumenda at ut saepe.</p>
                    <h3>john deo</h3>
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                </div>
            </div>

            <div class="swiper-slide box">
                <!-- <img src="image/pic-3.png" alt=""> -->
                <div class="content">
                    <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Ipsam incidunt quod praesentium iusto id autem possimus assumenda at ut saepe.</p>
                    <h3>john deo</h3>
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                </div>
            </div>

            <div class="swiper-slide box">
                <!-- <img src="image/pic-4.png" alt=""> -->
                <div class="content">
                    <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Ipsam incidunt quod praesentium iusto id autem possimus assumenda at ut saepe.</p>
                    <h3>john deo</h3>
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                </div>
            </div>

            <div class="swiper-slide box">
                <!-- <img src="image/pic-5.png" alt=""> -->
                <div class="content">
                    <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Ipsam incidunt quod praesentium iusto id autem possimus assumenda at ut saepe.</p>
                    <h3>john deo</h3>
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                </div>
            </div>

            <div class="swiper-slide box">
                <!-- <img src="image/pic-6.png" alt=""> -->
                <div class="content">
                    <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Ipsam incidunt quod praesentium iusto id autem possimus assumenda at ut saepe.</p>
                    <h3>john deo</h3>
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                </div>
            </div>

        </div>

        <div class="swiper-pagination"></div>

    </div>

</section>

<section class="contact" id="contact">

    <h1 class="heading"><span>contact</span> us</h1>

    <div class="row">

        <iframe class="map" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d30153.788252261566!2d72.82321484621745!3d19.141690214227783!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3be7b63aceef0c69%3A0x2aa80cf2287dfa3b!2sJogeshwari%20West%2C%20Mumbai%2C%20Maharashtra%20400047!5e0!3m2!1sen!2sin!4v1632137920043!5m2!1sen!2sin" allowfullscreen="" loading="lazy"></iframe>

        <form action="">
            <h3>get in touch</h3>
            <input type="text" placeholder="your name" class="box">
            <input type="email" placeholder="your email" class="box">
            <input type="tel" placeholder="subject" class="box">
            <textarea placeholder="your message" class="box" cols="30" rows="10"></textarea>
            <input type="submit" value="send message" class="btn">
        </form>

    </div>

</section>

<footer class="footer" id="footer">

    <section class="box-container">

        <div class="box">
            <h3>our branches</h3>
            <a href="#"> <i class="fas fa-map-marker-alt"></i> india </a>
            <a href="#"> <i class="fas fa-map-marker-alt"></i> japan </a>
            <a href="#"> <i class="fas fa-map-marker-alt"></i> france </a>
            <a href="#"> <i class="fas fa-map-marker-alt"></i> russia </a>
            <a href="#"> <i class="fas fa-map-marker-alt"></i> USA </a>
        </div>

        <div class="box">
            <h3>quick links</h3>
            <a href="#"> <i class="fas fa-arrow-right"></i> home </a>
            <a href="#"> <i class="fas fa-arrow-right"></i> vehicles </a>
            <a href="#"> <i class="fas fa-arrow-right"></i> services </a>
            <a href="#"> <i class="fas fa-arrow-right"></i> featured </a>
            <a href="#"> <i class="fas fa-arrow-right"></i> reviews </a>
            <a href="#"> <i class="fas fa-arrow-right"></i> contact </a>
        </div>

        <div class="box">
            <h3>contact info</h3>
            <a href="#"> <i class="fas fa-phone"></i> +123-456-7890 </a>
            <a href="#"> <i class="fas fa-phone"></i> +111-222-3333 </a>
            <a href="#"> <i class="fas fa-envelope"></i> shaikhanas@gmail.com </a>
            <a href="#"> <i class="fas fa-map-marker-alt"></i> mumbai, india - 400104 </a>
        </div>

        <div class="box">
            <h3>contact info</h3>
            <a href="#"> <i class="fab fa-facebook-f"></i> facebook </a>
            <a href="#"> <i class="fab fa-twitter"></i> twitter </a>
            <a href="#"> <i class="fab fa-instagram"></i> instagram </a>
            <a href="#"> <i class="fab fa-linkedin"></i> linkedin </a>
            <a href="#"> <i class="fab fa-pinterest"></i> pinterest </a>
        </div>

    </section>

    <div class="credit"> created by <span>mr. web designer</span> | all rights reserved </div>

</footer>

</div>


</template>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;300;400;500;600&display=swap');

:root{
    --yellow:#f9d806;
    --light-yellow:#ffee80;
    --black:#130f40;
    --light-color:#666;
    --box-shadow:0 .5rem 1rem rgba(0,0,0,.1);
    --border:.1rem solid rgba(0,0,0,.1);
}

*{
    font-family: 'Poppins', sans-serif;
    margin:0; padding:0;
    box-sizing: border-box;
    outline: none; border:none;
    text-decoration: none;
    text-transform: capitalize;
    transition: .2s linear;
}

html{
    font-size: 62.5%;
    overflow-x: hidden;
    scroll-padding-top: 7rem;
    scroll-behavior: smooth;
}

section{
    padding:2rem;
    margin: 0 auto;
    max-width: 1200px;
}

.heading{
    padding-bottom: 2rem;
    text-align: center;
    font-size: 4.5rem;
    color:var(--black);
}

.heading span{
    position: relative;
    z-index: 0;
}

.heading span::before{
    content: '';
    position: absolute;
    bottom:1rem; left:0;
    height: 100%;
    width: 100%;
    background: var(--light-yellow);
    z-index: -1;
    clip-path: polygon(0 90%, 100% 80%, 100% 100%, 0% 100%);
}

.btn{
    display: inline-block;
    margin-top: 1rem;
    padding:.8rem 3rem;
    background:var(--light-yellow);
    color:var(--black);
    cursor: pointer;
    font-size: 1.7rem;
    border-radius: .5rem;
    font-weight: 500;
    text-align: center;
}

.btn:hover{
    background:var(--yellow);
}

.header{
    position: fixed;
    top:0; left:0; right:0;
    z-index: 1000;
    background: #fff;
}

.header .flex{
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.header .logo{
    font-size: 2.5rem;
    color:var(--black);
    font-weight: bold;
}

.header .logo span{
    color:var(--yellow);
}

.header .navbar a{
    margin:0 1rem;
    font-size: 1.7rem;
    color:var(--black);
}

.header .navbar a:hover{
    color:var(--yellow);
}

#login-btn .btn{
    margin-top: 0;
}

#login-btn i{
    display: none;
    font-size: 2.5rem;
    color:var(--light-color);
}

.header.active{
    box-shadow: var(--box-shadow);
}

#menu-btn{
    font-size: 2.5rem;
    color:var(--light-color);
    display: none;
}

.login-form-container{
    position: fixed;
    top:-105%; left:0;
    height:100%;
    width:100%;
    display: flex;
    align-items: center;
    justify-content: center;
    background:rgba(255,255,255,.9);
    z-index: 10000;
}

.login-form-container.active{
    top:0;
}

.login-form-container form{
    margin:2rem;
    text-align: center;
    padding:2rem;
    width:40rem;
    border-radius: .5rem;
    box-shadow: var(--box-shadow);
    border:var(--border);
    background: #fff;
}

.login-form-container form .buttons{
    display: flex;
    gap:1rem;
    align-items: center;
}

.login-form-container form .btn{
    display: block;
    width:100%;
    margin:.5rem 0;
}

.login-form-container form .box{
    margin:.7rem 0;
    width: 100%;
    font-size: 1.6rem;
    color:var(--black);
    text-transform: none;
    border:var(--border);
    padding:1rem 1.2rem;
    border-radius: .5rem;
}

.login-form-container form p{
    padding:1rem 0;
    font-size: 1.5rem;
    color:var(--light-color);
}

.login-form-container form p a{
    color:var(--yellow);
    text-decoration: underline;
}

.login-form-container form p a:hover{
    color: var(--black);
}

.login-form-container form h3{
    padding-bottom:1rem;
    font-size: 2.5rem;
    color:var(--black);
    text-transform: uppercase;
}

.login-form-container #close-login-form{
    position: absolute;
    top:1.5rem; right:2.5rem;
    font-size: 5rem;
    color:var(--black);
    cursor: pointer;
}

.home{
    padding-top: 10rem;
    text-align: center;
    overflow-x: hidden;
}

.home h3{
    color:var(--black);
    font-size: 7.5vw;
    text-transform: uppercase;
}

.home img{
    width:100%;
    margin:1rem 0;
}

.icons-container{
    background: #eee;
}

.icons-container .box-container{
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(25rem, 1fr));
    gap:1.5rem;
    padding-top: 5rem;
    padding-bottom: 5rem;
}

.icons-container .box-container .box{
    background:#fff;
    display: flex;
    align-items: center;
    box-shadow: var(--box-shadow);
    border-radius: .5rem;
    padding:2rem;
    gap:1.5rem;
}

.icons-container .box-container .box i{
    height:5rem;
    width:5rem;
    line-height:5rem;
    font-size:2.5rem;
    color:var(--black);
    background:#eee;
    text-align: center;
    border-radius: 50%;
}

.icons-container .box-container .box .content h3{
    font-size: 2.5rem;
    color:var(--yellow);
}

.icons-container .box-container .box .content p{
    font-size: 1.5rem;
    color:var(--light-color);
}

.icons-container .box-container .box:hover{
    background:var(--black);
}

.icons-container .box-container .box:hover i{
    background:var(--yellow);
}

.icons-container .box-container .box:hover .content h3{
    color:#fff;
}

.icons-container .box-container .box:hover .content p{
    color:#eee;
}

.vehicles .vehicles-slider{
    padding-bottom: 6rem;
}

.vehicles .vehicles-slider .box{
    text-align: center;
}

.vehicles .vehicles-slider .box img{
    width:100%;
    transform: scale(.8);
    opacity: .5;
    height: 30rem;
    object-fit: contain;
}

.vehicles .vehicles-slider .box .content{
    padding-top: 1rem;
    transform: scale(0);
}

.vehicles .vehicles-slider .swiper-slide-active .content{
    transform: scale(1);
}

.vehicles .vehicles-slider .swiper-slide-active img{
    transform: scale(1);    
    opacity: 1;
}

.vehicles .vehicles-slider .box .content h3{
    font-size: 2.5rem;
    color:var(--black);
}

.vehicles .vehicles-slider .box .content .price{
    font-size: 2.2rem;
    color:var(--yellow);
    padding:1rem 0;
    font-weight: bolder;
}

.vehicles .vehicles-slider .box .content .price span{
    color:var(--light-color);
    font-size: 1.5rem;
    font-weight: normal;
}

.vehicles .vehicles-slider .box .content p{
    font-size: 1.6rem;
    color:var(--light-color);
    padding: 1rem 0;
    padding-top: 1.5rem;
    border-top: var(--border);
}

.vehicles .vehicles-slider .box .content span{
    font-size: 1rem;
    color:var(--yellow);
    padding:0 .5rem;
}

.swiper-pagination-bullet-active{
    background: var(--yellow);
}

.services .box-container{
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(30rem, 1fr));
    gap:1.5rem;
}

.services .box-container .box{
    padding:3rem 2rem;
    border-radius: .5rem;
    box-shadow: var(--box-shadow);
    border:var(--border);
    text-align: center;
}

.services .box-container .box i{
    height:6rem;
    width:6rem;
    line-height: 6rem;
    border-radius: 50%;
    font-size: 2.5rem;
    margin-bottom: 1rem;
    background:var(--yellow);
    color:var(--black);
}

.services .box-container .box h3{
    font-size: 2.2rem;
    color:var(--black);
}

.services .box-container .box p{
    line-height: 1.8;
    padding:1rem 0;
    font-size: 1.6rem;
    color:var(--light-color);
}

.services .box-container .box:hover{
    background: var(--black);
}

.services .box-container .box:hover h3{
    color:#fff;
}

.services .box-container .box:hover p{
    color:#eee;
}

.featured .featured-slider{
    padding:1rem;
    padding-bottom: 4rem;
}

.featured .featured-slider .box{
    padding:3rem 2rem;
    text-align: center;
    box-shadow: var(--box-shadow);
    border:var(--border);
    border-radius: .5rem;
}

.featured .featured-slider .box img{
    height: 15rem;
    width: 100%;
    object-fit: contain;
    margin-bottom: 1rem;
}

.featured .featured-slider .box:hover img{
    transform: scale(.9);
}

.featured .featured-slider .box .content h3{
    font-size: 2.2rem;
    color:var(--black);
}

.featured .featured-slider .box .content .stars{
    padding:1rem 0;
}

.featured .featured-slider .box .content .stars i{
    font-size: 1.7rem;
    color:var(--yellow);
}

.featured .featured-slider .box .content .price{
    font-size: 2.5rem;
    color:var(--black);
}


.newsletter-container{
    padding:6rem 2rem;
    background: url(../image/letter-bg.png) no-repeat;
    background-size: cover;
    background-position: center;
    text-align: center;
}

.newsletter h3{
    font-size: 3rem;
    color:var(--black);
}

.newsletter p{
    font-size: 1.5rem;
    color:var(--light-color);
    padding:1rem 0;
}

.newsletter form{
    max-width: 60rem;
    height:5rem;
    background:#fff;
    border-radius: 5rem;
    overflow:hidden;
    display: flex;
    margin:1rem auto;
    box-shadow: var(--box-shadow);
}

.newsletter form input[type="email"]{
    height: 100%;
    width:100%;
    padding:0 2rem;
    font-size: 1.6rem;
    color:var(--black);
    text-transform: none;
}

.newsletter form input[type="submit"]{
    height: 100%;
    width:17rem;
    font-size: 1.7rem;
    color:var(--black);
    background: var(--light-yellow);
    cursor: pointer;
}

.newsletter form input[type="submit"]:hover{
    background: var(--yellow);
}

.reviews .review-slider{
    padding-bottom: 3rem;
}

.reviews .review-slider .box{
    text-align: center;
    padding:2rem;
    margin-bottom: 2rem;
    user-select: none;
    opacity: .4;
    transform: scale(.9);
}

.reviews .review-slider .swiper-slide-active{
    opacity: 1;
    transform: scale(1);
    box-shadow: var(--box-shadow);
    border:var(--border);
    border-radius: .5rem;
}

.reviews .review-slider .box img{
    height:7rem;
    width:7rem;
    border-radius: 50%;
    object-fit: cover;
}

.reviews .review-slider .box .content p{
    color:var(--light-color);
    font-size: 1.6rem;
    line-height: 1.8;
    padding:1rem 0;
}

.reviews .review-slider .box .content h3{
    color:var(--black);
    font-size: 2.2rem;
    padding-bottom: .5rem;
}

.reviews .review-slider .box .content .stars i{
    color:var(--yellow);
    font-size: 1.7rem;
}

.contact .row{
    display: flex;
    flex-wrap: wrap;
    gap:1.5rem;
    padding-bottom: 1rem;
}

.contact .row .map{
    flex:1 1 42rem;
    width: 100%;
    padding:2rem;
    box-shadow: var(--box-shadow);
    border:var(--border);
    border-radius: .5rem;
}

.contact .row form{
    padding:2rem;
    flex:1 1 42rem;
    box-shadow: var(--box-shadow);
    border:var(--border);
    text-align: center;
    border-radius: .5rem;
}

.contact .row form h3{
    font-size: 3rem;
    color:var(--black);
    padding-bottom: 1rem;
}

.contact .row form .box{
    width:100%;
    border-radius: .5rem;
    padding:1rem 1.2rem;
    font-size: 1.6rem;
    text-transform: none;
    border:var(--border);
    margin:.7rem 0;
}

.contact .row form textarea{
    height:15rem;
    resize: none;
}

.footer{
    background: var(--light-yellow);
}

.footer .box-container{
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(25rem, 1fr));
    gap:1.5rem;
}

.footer .box-container .box h3{
    font-size: 2.2rem;
    padding:1rem 0;
    color:var(--black);
}

.footer .box-container .box a{
    display: block;
    font-size: 1.4rem;
    padding:1rem 0;
    color:var(--light-color);
}

.footer .box-container .box a i{
    padding-right: .5rem;
    color:var(--black);
}

.footer .box-container .box a:hover i{
    padding-right: 2rem;
}

.footer .credit{
    text-align: center;
    padding:3rem 2rem;
    margin-top: 2rem;
    font-size: 2rem;
    color:#fff;
    background-color: var(--black);
}

.footer .credit span{
    color: var(--yellow);
}
















@media (max-width:991px){

    html{
        font-size: 55%;
    }

}

@media (max-width:768px){

    #menu-btn{
        display: block;
    }

    #menu-btn.fa-times{
        transform:rotate(180deg);
    }

    #login-btn .btn{
        display: none;
    }

    #login-btn i{
        display: block;
    }
    
    .header .flex{
        position: relative;
    }

    .header .navbar{
        position: absolute;
        top:99%; left:0; right:0;
        background: #fff;
        border-top: var(--border);
        clip-path: polygon(0 0, 100% 0, 100% 0, 0 0);
    }

    .header .navbar.active{
        clip-path: polygon(0 0, 100% 0, 100% 100%, 0% 100%);
    }

    .header .navbar a{
        margin:2rem;
        display: block;
        font-size: 2rem;
    }

}

@media (max-width:450px){

    html{
        font-size: 50%;
    }

    .heading{
        font-size: 3rem;
    }

}
</style>