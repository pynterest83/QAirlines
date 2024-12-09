// Graph.jsx
import React from 'react';
import { Bar } from 'react-chartjs-2';

import {
    Chart as ChartJS,
    BarElement,
    CategoryScale,
    LinearScale,
    Title,
    Tooltip,
    Legend
} from 'chart.js';

ChartJS.register(BarElement, CategoryScale, LinearScale, Title, Tooltip, Legend);

const Graph = ({ chartData }) => {
  return (
    <Bar
      data={chartData}
      options={{
        plugins: {
          legend: { display: false },
          title: {
            display: true,
            text: 'Monthly Bookings for the Year 2024',
          },
        },
      }}
    />
  );
};

export default Graph;
