<script lang="ts">
    import Fa from 'svelte-fa'
    import { faTimesCircle,faHeart } from '@fortawesome/free-solid-svg-icons'
    import { onMount } from 'svelte';
    import type {Account} from "../store/AccountStore";

    export let accounts: Account

    $: index = 0
    $: select = accounts[index]
    $: url = accounts[index].photo
   const approve = () => {
     index = index + 1
     console.log(index)
   }

   const decline = () => {
     index = index + 1
     console.log(index)
   }

</script>

<div class="gen-container">
<div class="slides">
    {#each accounts as account }
            <div class="flip-card" class:showing={account == select}>
                <div class="flip-card-inner">
                    <div class="flip-card-front">
                        <img src={url} alt="Avatar" style="width:600px;height:600px;">
                    </div>
                    <div class="flip-card-back">
                        <h1>John Doe</h1>
                        <p>Architect & Engineer</p>
                        <p>We love that guy</p>
                    </div>
                </div>
            </div>
    {/each}
</div>

<div class="slide-controls">
  <span id="decline" on:click={decline}><Fa icon={faTimesCircle} size="4x" /></span>
  <span id="approve" on:click={approve}><Fa icon={faHeart} size="4x"/></span>
</div>

</div>

<style>
    .slide-controls {
        margin-top: 10rem;
        display: flex;
        justify-content: space-between;
        padding-left: 5%;
    }
    #decline, #approve {
        width: 150px;
    }

    .gen-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }

    .flip-card {
        border-radius: 5px;
        opacity: 0;
        z-index: 1;
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