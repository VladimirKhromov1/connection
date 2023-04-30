<script lang="ts">
    import type {Account} from "../store/AccountStore";
    import Fa from 'svelte-fa'
    import { faMapMarker } from '@fortawesome/free-solid-svg-icons'
    import AccountData from "./AccountData.svelte";

    export let accounts: Account
    export let current_account_id: number
    export let waitAnswerIds: number[]
    export let waitAnswerFromMeIds: number[]
</script>

<div class="d-flex align-items-start">
{#each accounts as account }
    <div class="elements item">
    <div class="flip-card">
        <div class="flip-card-inner">
            <div class="flip-card-front">
                <img src={account.photo} style="width:400px;height:400px;">
            </div>
            <div class="flip-card-back">
               <AccountData account={account}/>
            </div>
        </div>
    </div>

    <div class="buttons">
      <a class="btn btn-lg btn-primary" href="/show/{current_account_id}/{account.id}" target="_blank">Chat with {account.username}</a>
      {#if waitAnswerIds.includes(account.id)}
          <button type="button" class="btn btn-secondary btn-lg" disabled>Wait answer</button>
      {:else if waitAnswerFromMeIds.includes(account.id)}
          <button type="button" class="btn btn-secondary btn-lg" disabled>Wait answer from me</button>
      {:else }
          <a class="btn btn-lg btn-primary" href="/date/{current_account_id}/{account.id}">Date with {account.username}</a>
      {/if}
    </div>

    </div>
{/each}
</div>

<style>
    .elements {
        display: flex;
        flex-direction: column;
    }

    .slide {
        margin-top: 8rem;
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

    .buttons {
        display: flex;
        margin-top: 10rem;
        width: 86%;
        justify-content: space-between;
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