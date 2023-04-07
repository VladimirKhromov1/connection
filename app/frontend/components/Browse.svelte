<script lang="ts">
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

<button class="controls" id="decline" >Decline</button>
<button class="controls" id="approve">Approve</button>

<style>
    #slides {
        width: 50vw;
        height: 50vh;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        position: relative;
        transition: opacity 0.1s ease-in-out;
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