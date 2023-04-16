<script lang="ts">
    import type {Account} from "../store/AccountStore";
    import Fa from 'svelte-fa'
    import { faMapMarker } from '@fortawesome/free-solid-svg-icons'

    export let accounts: Account
    export let current_account_id: number
</script>

<div class="d-flex align-items-start">
{#each accounts as account }
    <div class="elements">
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

    <div class="buttons">
      <a class="btn btn-primary slide" href="/show/{current_account_id}/{account.id}" target="_blank">Chat with {account.username}</a>
      <a class="btn btn-primary slide" href="/date/{current_account_id}/{account.id}" target="_blank">Date with {account.username}</a>
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