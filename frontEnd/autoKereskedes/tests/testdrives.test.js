import { describe, it, expect, beforeEach, vi } from 'vitest';
import { mount, flushPromises } from '@vue/test-utils';
import { createPinia, setActivePinia } from 'pinia';
import { nextTick } from 'vue';
import TestDrivesPage from '../src/pages/testDrives.vue';
import TestCard from '../src/components/testCard.vue';
import { useController } from '../src/stores/UIcontrol';

global.fetch = vi.fn();

describe('TestDrivesPage', () => {
  let pinia;

  beforeEach(() => {
    pinia = createPinia();
    setActivePinia(pinia);
    
    vi.clearAllMocks();
    
    const store = useController();
    store.id = 123;
  });

  it('rendereli a komponenst a címmel', async () => {
    fetch
      .mockResolvedValueOnce({ json: async () => [] })
      .mockResolvedValueOnce({ json: async () => [] });

    const wrapper = mount(TestDrivesPage, {
      global: {
        plugins: [pinia],
        stubs: {
          TestCard: true
        }
      }
    });
    
    await flushPromises();
    
    expect(wrapper.find('.pageTitle h1').text()).toBe('Teszt vezetéseim');
  });

  it('megjeleníti az üres állapot üzenetet, ha nincsenek teszt vezetések', async () => {
    fetch
      .mockResolvedValueOnce({ json: async () => [] })
      .mockResolvedValueOnce({ json: async () => [] });

    const wrapper = mount(TestDrivesPage, {
      global: {
        plugins: [pinia],
        stubs: {
          TestCard: true
        }
      }
    });
    
    await flushPromises();

    expect(wrapper.find('.noTestDrives').exists()).toBe(true);
    expect(wrapper.find('.noTestDrives').text()).toBe('Nincsenek teszt vezetéseid.');
  });

  it('megjeleníti a teszt vezetéseket, ha vannak adatok', async () => {
    const mockFavs = [
      { autoId: 1 },
      { autoId: 1 },
      { autoId: 2 }
    ];

    const mockTestDrives = [
      {
        id: 1,
        datum: '2024-01-15T10:00:00',
        Autok: { id: 1, marka: 'BMW', modell: 'X5' }
      },
      {
        id: 2,
        datum: '2024-01-20T14:00:00',
        Autok: { id: 2, marka: 'Audi', modell: 'A4' }
      }
    ];

    fetch
      .mockResolvedValueOnce({ json: async () => mockFavs })
      .mockResolvedValueOnce({ json: async () => mockTestDrives });

    const wrapper = mount(TestDrivesPage, {
      global: {
        plugins: [pinia],
        stubs: {
          TestCard: true
        }
      }
    });

    await flushPromises();
    await nextTick();

    expect(wrapper.findAll('.testItem')).toHaveLength(2);
    expect(wrapper.find('.noTestDrives').exists()).toBe(false);
  });
});