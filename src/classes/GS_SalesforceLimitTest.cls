public class GS_SalesforceLimitTest {

    public static void testSoqlLimit() {
        System.debug('Limits.getCallouts() = ' + Limits.getCallouts());
        System.debug('Limits.getHeapSize() = ' + Limits.getHeapSize());
        System.debug('Limits.getCpuTime() = ' + Limits.getCpuTime());

        Integer totalQueriesNumber = 0;
        for (Integer i = 0; i < 50; i++) {
            Map<String, Integer> result = (Map<String, Integer>)GS_Executor.execute('100QueryTest', null, Map<String, Integer>.class);
            totalQueriesNumber += result.get('getQueries');
        }
        System.assertEquals(5000, totalQueriesNumber, 'Total Queries Number Mismatch');

        System.debug('Limits.getCallouts() = ' + Limits.getCallouts());
        System.debug('Limits.getLimitCallouts() = ' + Limits.getLimitCallouts());

        System.debug('Limits.getHeapSize() = ' + Limits.getHeapSize());
        System.debug('Limits.getLimitHeapSize() = ' + Limits.getLimitHeapSize());

        System.debug('Limits.getCpuTime() = ' + Limits.getCpuTime());
        System.debug('Limits.getLimitCpuTime() = ' + Limits.getLimitCpuTime());
    }
}