<script lang="ts">
    import axios from 'axios';
    import { fade, fly } from 'svelte/transition';
    import Fa from 'svelte-fa'
    import { faTimesCircle,faHeart, faMapMarker } from '@fortawesome/free-solid-svg-icons'
    import { onMount } from 'svelte';
    import type {Account} from "../store/AccountStore";

    export let accounts: Account

    $: index = 0
    $: clickApprove = false
    $: clickDecline = false
    let like = false
    let dislike = false
    $: select = accounts[index]
    $: prev = accounts[index - 1]
    $: url = accounts[index]?.photo
   const approve = () => {
     var url = "http://localhost:3000/approve/" + select.id;
       fetch(url, {
           method: 'POST',
       })
     like = true
     clickApprove = true
     index = index + 1
     setTimeout(() => (like = false), 260)
     setTimeout(() => (clickApprove = false), 700)
   }

   const decline = () => {
     dislike = true
     clickDecline = true
     index = index + 1
     setTimeout(() => (dislike = false), 200)
     setTimeout(() => (clickDecline = false), 700)
     console.log(index)
   }

</script>

<div class="gen-container">
<div class="slides">
    {#if index < accounts.length}
        {#each accounts as account }
            <span class="like" class:showing={like} transition:fade>Like!</span>
            <span class="dislike" class:showing={dislike} transition:fade>Dislike!</span>
            <div class="flip-card" class:showing={account == select} class:rotate-left={clickDecline && account == prev}  class:rotate-right={clickApprove && account == prev} out:fade>
                <div class="flip-card-inner">
                    <div class="flip-card-front">
                        <img src={url} style="width:600px;height:600px;">
                    </div>
                    <div class="flip-card-back">
                        <h1>{account.firstName} {account.lastName}</h1>
                        <Fa icon={faMapMarker}  /> <h2>Location</h2>
                        <p>We love that guy</p>
                    </div>
                </div>
            </div>
        {/each}
        <div class="slide-controls">
            <span class="decline" on:click={decline}><Fa icon={faTimesCircle} size="4x" /></span>
            <span class="approve" on:click={approve}><Fa icon={faHeart} size="4x"/></span>
        </div>
     {/if}
</div>

</div>

<style>
    .like {
        opacity: 0;
        z-index: 0;
        border-radius: 5px;
        padding: 5px 10px;
        border: 2px solid green;
        color: green;
        text-transform: uppercase;
        font-size: 15px;
        position: absolute;
        top: 50px;
        right: 38%;
        text-shadow: none;
    }
    .dislike {
        opacity: 0;
        z-index: 1;
        border-radius: 5px;
        padding: 5px 10px;
        border: 2px solid red;
        color: red;
        text-transform: uppercase;
        font-size: 15px;
        position: absolute;
        top: 50px;
        left: 35%;
        text-shadow: none;
    }
    .rotate-right {
        transform: rotate(30deg) scale(0.8);
        transition: 1s;
        margin-left: 400px;
        cursor: e-resize;
        opacity: 0;
        z-index: 10;
    }
    .rotate-left {
        transform: rotate(-30deg) scale(0.8);
        transition: 1s;
        opacity: 0;
        margin-left: -400px;
        cursor: w-resize;
        z-index: 10;
    }
    .slide-controls {
        margin-top: 40rem;
        display: flex;
        justify-content: space-between;
        z-index: 2;
    }

    .decline {
        width: 150px;
        color: #CDD6DD;
    }

    .approve {
        width: 150px;
        color: #FFACE4;
    }

    .gen-container {
        position: relative;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }

    .flip-card {
        left: 32%;
        position: absolute;
        box-sizing: border-box;
        border-radius: 5px;
        opacity: 0;
        background-color: transparent;
        width: 600px;
        height: 500px;
        border: 1px solid #f1f1f1;
        perspective: 1000px; /* Remove this if you don't want the 3D effect */
    }

    .flip-card-inner {
        position: relative;
        width: 100%;
        height: 100%;
        text-align: center;
        transition: transform 0.8s;
        transform-style: preserve-3d;
    }

    .flip-card:hover .flip-card-inner {
        transform: rotateY(180deg);
    }

    .flip-card-front, .flip-card-back {
        position: absolute;
        width: 100%;
        height: 100%;
        -webkit-backface-visibility: hidden; /* Safari */
        backface-visibility: hidden;
    }

    .flip-card-front {
        border-radius: 5px 5px 0 0;
        background-color: #bbb;
        color: black;
    }

    .flip-card-back {
        background-color: dodgerblue;
        color: white;
        transform: rotateY(180deg);
    }

    .showing {
        opacity: 1;
        z-index: 2;
    }
</style>