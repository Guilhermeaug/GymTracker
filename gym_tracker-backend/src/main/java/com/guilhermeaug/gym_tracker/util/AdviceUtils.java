package com.guilhermeaug.gym_tracker.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdviceUtils {
    public static Map<String, List<String>> getErrorsMap(List<String> errors) {
        Map<String, List<String>> errorResponse = new HashMap<>();
        errorResponse.put("errors", errors);
        return errorResponse;
    }

}
