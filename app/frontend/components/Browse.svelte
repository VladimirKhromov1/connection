<script lang="ts">
    import Fa from 'svelte-fa'
    import { faTimesCircle,faHeart } from '@fortawesome/free-solid-svg-icons'
    import { onMount } from 'svelte';
    import type {Account} from "../store/AccountStore";

    export let accounts: Account

    $: index = 0
    $: select = accounts[index]
   const approve = () => {
     index = index + 1
   }

   const decline = () => {
     index = index + 1
   }

</script>

<ul id="slides">
    {#each accounts as account }
        <li class="slide" class:showing={account == select}>{account.email}</li>
    {/each}
</ul>

<div class="slide-controls">
  <span id="decline" on:click={decline}><Fa icon={faTimesCircle} size="4x" /></span>
  <span id="approve" on:click={approve}><Fa icon={faHeart} size="4x"/></span>
</div>

<style>
    .slide-controls {
        width: 100%;
        text-align: center;
    }
    #slides {
       position: relative;
       height : 400px;
       padding: 0px;
       margin-left: 200px;
       margin-right: 200px;
       list-style-type: none;
    }
    #decline {
        margin-right: 30px;
    }

    .slide {
        position: absolute;
        left: 0px;
        top: 0px;
        width: 100%;
        height: 100%;
        opacity: 0;
        z-index: 1;

        -webkit-transition: opacity 1s;
        -moz-transition: opacity 1s;
        -o-transition: opacity 1s;
        transition: opacity 1s;
    }

    .showing {
        opacity: 1;
        z-index: 2;
    }

    .slide {
        font-size: 40px;
        padding: 40px;
        box-sizing: border-box;
        background: #333;
        color: #fff;
    }
</style>