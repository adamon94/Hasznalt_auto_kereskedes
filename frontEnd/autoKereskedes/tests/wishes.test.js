import { describe, it, expect, beforeEach, vi } from 'vitest';
import { mount, flushPromises } from '@vue/test-utils';
import { nextTick } from 'vue';
import WishesPage from '../src/pages/wishes.vue';
import WishForm from '../src/components/wishComps/wishForm.vue';
import WishList from '../src/components/wishComps/wishList.vue';
import FavCard from '../src/components/favCard.vue';

describe('WishesPage', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('rendereli a kívánságlista oldalt a címmel', async () => {
    const wrapper = mount(WishesPage, {
      global: {
        stubs: {
          WishForm: true,
          WishList: true,
          FavCard: true
        }
      }
    });

    await nextTick();

    expect(wrapper.find('.pageTitle h1').text()).toBe('Kívánságlistám');
  });

  it('megjeleníti a találatokat amikor vannak megfelelő autók', async () => {
    const wrapper = mount(WishesPage, {
      global: {
        stubs: {
          WishForm: true,
          WishList: true,
          FavCard: true
        }
      }
    });

    await nextTick();

    const vm = wrapper.vm;
    vm.wishes.push({ brand: 'Toyota', model: '', year: null });

    await nextTick();

    expect(vm.matches.length).toBeGreaterThan(0);
    expect(wrapper.find('.matchesList h2').exists()).toBe(true);
    expect(wrapper.find('.matchesList h2').text()).toBe('Találatok a kívánságaid alapján:');
  });

  it('megjeleníti az üres állapot üzenetet, ha nincsenek találatok', async () => {
    const wrapper = mount(WishesPage, {
      global: {
        stubs: {
          WishForm: true,
          WishList: true,
          FavCard: true
        }
      }
    });

    await nextTick();

    const vm = wrapper.vm;
    vm.wishes.push({ brand: 'Ferrari', model: '', year: null });

    await nextTick();

    expect(vm.matches.length).toBe(0);
    expect(wrapper.find('.noMatches h2').exists()).toBe(true);
    expect(wrapper.find('.noMatches h2').text()).toBe('Nincsenek találatok a kívánságaid alapján.');
  });
});