<script lang="ts">
    import type {Date} from "../store/DateStore";
    import type {Account} from "../store/AccountStore";
    import {onMount} from "svelte";

    export let dates: Date
    export let сurrentAccountId: number

    onMount(async () => {
        const url = "http://localhost:3000/check_dates/";
        fetch(url, {
            method: 'PUT',
        })
    });

</script>

{#each dates as date}
    <div class="border rounded-5 date">
        <section class="p-4 text-center">
            {#if сurrentAccountId == date.creator.id}
                <img class="date-img" src={date.recipient.photo} alt="pic">
                <h3 class="date-text">Date with {date.recipient.username} {date.recipient.lastName}</h3>
            {:else}
                <img class="date-img" src={date.creator.photo} alt="pic">
                <h3 class="date-text">Date with {date.creator.username} {date.creator.lastName}</h3>
            {/if}
        </section>
        <div class="p-4 text-center border-top">
            {#if date.responsed == "closed"}
                <button type="button" class="btn btn-danger btn-lg" disabled>Time over</button>
            {:else if date.responsed == "default" && сurrentAccountId != date.creator.id}
                <a class="btn btn-success btn-lg accept" href="approve_date/{date.id}">Approve</a>
                <a class="btn btn-danger btn-lg" href="decline_date/{date.id}">Decline</a>
            {:else if date.responsed == "default" && сurrentAccountId == date.creator.id}
                <button type="button" class="btn btn-secondary btn-lg" disabled>Wait answer</button>
            {:else if date.responsed == "declined"}
                <button type="button" class="btn btn-secondary btn-lg reject" disabled>Rejected</button>
            {:else }
                <a type="button" class="btn btn-primary btn-lg button-link" href="show_date/{date.id}" target="_blank">Link to Date</a>
            {/if}
        </div>
    </div>
{/each}

<style>
    .button-link {
        width: 300px;
    }
    .accept {
        margin-right: 3rem;
    }
    .reject {
        width: 300px;
        color: #B00100;
    }
    .date {
        margin-right: 20%;
        margin-left: 20%;
        margin-bottom: 5rem;
    }
    .date-text {
        font-family: "Arial Black";
    }
    img {
        border-radius: 50%;
        float: left;
        width: 60px;
        height: 60px;
    }
    .date-img {
        margin-top: -0.6rem;
    }
</style>