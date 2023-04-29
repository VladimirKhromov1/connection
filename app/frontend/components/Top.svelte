<script lang="ts">
    import type {Account} from "../store/AccountStore";
    import {faMapMarker} from "@fortawesome/free-solid-svg-icons";
    import Fa from 'svelte-fa'

    export let accounts: Account

</script>

<div class="top-users">
    {#each accounts as account, index }
        <div class="top-user">
            <div class="flip-card">
                <div class="flip-card-inner">
                    <div class="flip-card-front">
                        <img src={account.photo} style="width:400px;height:400px;">
                    </div>
                    <div class="flip-card-back">
                        <h1>{account.firstName} {account.lastName}</h1>
                        <Fa icon={faMapMarker}  /> <h2>Location</h2>
                        <p>{account.age}</p>
                    </div>
                </div>
            </div>
        {#if index == 0}
            <div class="circle1">1</div>
        {:else if index == 1}
            <div class="circle2">2</div>
        {:else}
            <div class="circle3">3</div>
        {/if}
        </div>
    {/each}
</div>

<style>
    .top-user {
        display: flex;
        flex-direction: column;
    }
    .circle1 {
        margin-left: 35%;
        margin-top: 30%;
        border-radius: 50%;
        width: 70px;
        height: 70px;
        padding-top: 6px;
        background: #86f60c;
        border: 3px solid #000;
        color: #000;
        text-align: center;
        font: 40px Arial, sans-serif;
    }
    .circle2 {
        margin-left: 35%;
        margin-top: 30%;
        border-radius: 50%;
        width: 70px;
        height: 70px;
        padding-top: 6px;
        background: #f1a80d;
        border: 3px solid #000;
        color: #000;
        text-align: center;
        font: 40px Arial, sans-serif;
    }
    .circle3 {
        margin-left: 35%;
        margin-top: 30%;
        border-radius: 50%;
        width: 70px;
        height: 70px;
        padding-top: 6px;
        background: #c52525;
        border: 3px solid #000;
        color: #000;
        text-align: center;
        font: 40px Arial, sans-serif;
    }
    .top-users {
        display: flex;
        align-items: center;
        justify-content: center;
        margin-top: 10%;
    }

    .flip-card {
        margin-right: 4rem;
        box-sizing: border-box;
        border-radius: 5px;
        background-color: transparent;
        width: 400px;
        height: 300px;
        border: 1px solid #f1f1f1;
        perspective: 1000px;
    }

    .flip-card-inner {
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
</style>