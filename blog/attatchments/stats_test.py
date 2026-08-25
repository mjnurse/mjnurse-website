"""
Calculate the number of tests required to reach a level of assurance errors don't exist.

Usage: python3 stats_test (script will describe parameter options) OR include stats_test

This package includes 3 functions:
(1) A function which calculates the number of tests required over a set of data to reach a certain level of
certainty that the likelihood of an error is below a certain percent.
(2) A procedure which displays a grid of the number of test required for a range of error likelihood and
levels of certainty.
(3) A procedure which tests that the calculated number of tests required is correct in a actual worked 
example, running 'n' test sets of 'm' records with a specified likelihood of and error.

mjnurse.uk - 2019
"""

import random
import sys
import time

PRINT_DETAIL = False


def tests_required(bad_rec_perc, set_size, target_certainty_perc):
   """
   A function to calculate the number of tests required over a set of data to reach a certain level of
   certainty that the likelihood of an error is below a certain percent.
   """

   bad_rec_frac = bad_rec_perc / 100.0
   target_certainty_frac = target_certainty_perc / 100.0
   good_rec_frac = 1 - bad_rec_frac

   num_tests_grs_removed = 0
   num_tests_grs_remain = 0

   # br = bad_record, grs = good_records

   perc_wont_find_br_when_grs_removed = 1.0  # 100% - no tests so no chance of finding
   perc_wont_find_br_when_grs_remain = 1.0

   found_rec_removed_result = False
   found_rec_remain_result = False

   for test_num in range(0, 1000000000):

      if not found_rec_removed_result:
         if test_num == set_size:
            perc_wont_find_br_when_grs_removed = 0
         else:
            perc_wont_find_br_when_grs_removed *= (good_rec_frac * float(set_size) - float(test_num)) \
                                                / float(set_size - test_num)
      if not found_rec_remain_result:
         perc_wont_find_br_when_grs_remain *= good_rec_frac

      perc_will_find_br_when_grs_removed = 1 - perc_wont_find_br_when_grs_removed
      perc_will_find_br_when_grs_remain = 1 - perc_wont_find_br_when_grs_remain

      if PRINT_DETAIL:
         print('test:', test_num + 1, '| remove', 'wont', round(perc_wont_find_br_when_grs_removed, 2),
               'will', round(perc_will_find_br_when_grs_removed, 2), '| remain', 'wont',
               round(perc_wont_find_br_when_grs_remain, 2), 'will',
               round(perc_will_find_br_when_grs_remain, 2))

      if perc_will_find_br_when_grs_removed >= target_certainty_frac and \
         not found_rec_removed_result:
         num_tests_grs_removed = test_num + 1
         found_rec_removed_result = True

      if perc_will_find_br_when_grs_remain >= target_certainty_frac and \
         not found_rec_remain_result:
         num_tests_grs_remain = test_num + 1
         found_rec_remain_result = True

      if found_rec_removed_result and found_rec_remain_result:
         break
   return(num_tests_grs_removed, num_tests_grs_remain) 

def generate_test_stats_matrix(
   num_bad_rec_perc_rows, bad_rec_perc_min, bad_rec_perc_max,
   num_trgt_cert_perc_cols, target_certainty_perc_min,
   target_certainty_perc_max, set_size):
   """
   A procedure which displays a grid of the number of test required for a range of error likelihood and
   levels of certainty.
   """

   bad_rec_frac_min = float(bad_rec_perc_min) / 100.0
   bad_rec_frac_max = float(bad_rec_perc_max) / 100.0
   bad_rec_frac_step = (bad_rec_frac_max - bad_rec_frac_min) / (float(num_bad_rec_perc_rows) - 1)

   trgt_cert_frac_min = float(target_certainty_perc_min) / 100.0
   trgt_cert_frac_max = float(target_certainty_perc_max) / 100.0
   trgt_cert_frac_step = (trgt_cert_frac_max - trgt_cert_frac_min) / (float(num_trgt_cert_perc_cols) - 1)

   print()
   print('                 | Target Certainty Percent')
   print('Maximum Bad      | ' + ('-' * (int(num_trgt_cert_perc_cols) * 8 - 1)))
   res_line = 'Records Percent  |'
   trgt_cert_frac = trgt_cert_frac_min
   for trgt_cert_itr in range(0, int(num_trgt_cert_perc_cols)):
      res_line += '{:>7.2f}%'.format(trgt_cert_frac * 100)
      trgt_cert_frac += trgt_cert_frac_step
   print(res_line)
   res_line = '---------------- |'
   for trgt_cert_itr in range(0, int(num_trgt_cert_perc_cols)):
      res_line += ' -------'
   print(res_line)

   bad_rec_frac = bad_rec_frac_min
   for bad_rec_itr in range(0, int(num_bad_rec_perc_rows)):
      res_line_removed = ''
      res_line_remain = ''
      trgt_cert_frac = trgt_cert_frac_min
      for trgt_cert_itr in range(0, int(num_trgt_cert_perc_cols)):
         test_counts = tests_required(bad_rec_frac * 100.0, set_size, trgt_cert_frac * 100.0)
         res_line_removed += '{:>8,}'.format(test_counts[0])
         res_line_remain += '{:>8,}'.format(test_counts[1])
         trgt_cert_frac += trgt_cert_frac_step
      print('{:>6.3f}% | remove |'.format(bad_rec_frac * 100) + res_line_removed)
      print('        | remain |'.format(bad_rec_frac * 100) + res_line_remain)
      bad_rec_frac += bad_rec_frac_step

def test_stats(num_test_sets, bad_rec_perc, set_size, num_of_tests):
   """
   A procedure which tests that the calculated number of tests required is correct in a actual worked 
   example, running 'n' test sets of 'm' records with a specified likelihood of and error.
   """
   num_bad_records = set_size * bad_rec_perc / 100.0
   num_successful = 0
   start_time = time.time()
   prev_time = start_time
   for set_num in range(0, num_test_sets):
      curr_time = time.time()
      if (curr_time - prev_time) > 5:
         time_running = curr_time - start_time
         print('set num: {} of {}, secs running {:1.0f}, est secs remaining {:1.0f}'.format(
               set_num, num_test_sets, time_running, 
               time_running * float(num_test_sets)/float(set_num) - time_running))
         prev_time = curr_time
      bad_rec_found = False
      for test_num in range(0, num_of_tests):
         if random.randint(0, set_size) <= num_bad_records:
            bad_rec_found = True
            break
      if bad_rec_found:
         num_successful += 1
   print()
   print('num test sets:', num_test_sets, ', num which found bad record:', num_successful,
         ', percentage: {:3.2f}%'.format(float(num_successful) / float(num_test_sets) * 100.0))

"""
The following code allows the python script to be executed directly (as well as included as a package in
other python scripts.
"""
if __name__ == "__main__":

   if (len(sys.argv) < 2 or 
       (sys.argv[1] == '-g' and len(sys.argv) < 7) or
       (sys.argv[1] != '-g' and len(sys.argv) < 4)):
      print('Usage:')
      print()
      print('(1)', sys.argv[0], '<bad record perc> <set size> <target certainty perc>')
      print()
      print('(2)', sys.argv[0], '-g <1> <2> <3> <4> <5> <6> <7>')
      print()
      print('    Where: <1> - number bad record percentage rows in grid')
      print('           <2> - bad record percentage min')
      print('           <3> - bad record percentage max')
      print('           <4> - number target certainty percentage columns in grid')
      print('           <5> - target certainty percentage min')
      print('           <6> - target certainty percentage max')
      print('           <7> - test data set size')
      print()
      print('(3)', sys.argv[0], '-t <num test sets> <bad rec perc> <set size> <num of tests>')
      print()
      print('Percentages (perc) in range 0 - 100')
   elif sys.argv[1] == '-g':
      generate_test_stats_matrix(int(sys.argv[2]), float(sys.argv[3]), float(sys.argv[4]),
                                 int(sys.argv[5]), float(sys.argv[6]), float(sys.argv[7]),
                                 int(sys.argv[8]))
   elif sys.argv[1] == '-t':
      test_stats(int(sys.argv[2]), float(sys.argv[3]), int(sys.argv[4]), int(sys.argv[5]))
      
   else:
      bad_rec_perc = float(sys.argv[1])
      set_size = int(sys.argv[2])
      target_certainty_perc = float(sys.argv[3])

      print('-' * 80)
      print('bad record likelihood:', bad_rec_perc, '%')
      print('set size:             ', set_size)
      print('target certainty:     ', target_certainty_perc, '%')
      print('-' * 80)

      test_results = tests_required(bad_rec_perc, set_size, target_certainty_perc)

      print('With good recs removed -   reached target certainty ' + str(target_certainty_perc) + '% ' +
            'after ' + str(test_results[0]) + ' tests')
      print('With good recs remaining - reached target certainty ' + str(target_certainty_perc) + '% ' +
            'after ' + str(test_results[1]) + ' tests')
      print('-' * 80)
